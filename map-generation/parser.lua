-- Recursive Descent Parser for Factorio Noise DSL
-- Assumes a token stream from the lexer like: { {type="Keyword", value="if"}, ... }
local Parser = {}
Parser.__index = Parser

local token_patterns = { {
    type = "Whitespace",
    pattern = "^%s+"
}, {
    type = "Number",
    pattern = "^-?0x[%da-fA-F]+"
},
    {
        type = "Number",
        pattern = "^-?%d+%.?%d*[eE]%-?%d*"
    },
    {
        type = "Number",
        pattern = "^-?%d+%.?%d*"
    },
    {
        type = "Number",
        pattern = "^-?%.%d+[eE]%-?%d*"
    },
    {
        type = "Number",
        pattern = "^-?%.%d+"
    }, {
    type = "Keyword",
    pattern = "^var%("
}, {
    type = "LParen",
    pattern = "^%("
}, {
    type = "RParen",
    pattern = "^%)"
}, {
    type = "StringLiteral",
    pattern = "^\'[^\']*\'"
}, {
    type = "Identifier",
    pattern = "^[%a_][%w_:%.]*"
}, {
    type = "Operator",
    pattern = "^=="
}, {
    type = "Operator",
    pattern = "^>="
}, {
    type = "Operator",
    pattern = "^<="
}, {
    type = "Operator",
    pattern = "^!="
}, {
    type = "Operator",
    pattern = "^~="
}, {
    type = "Operator",
    pattern = "^[-+\\*/><!~%%&^]"
}, {
    type = "Assignment",
    pattern = "^="
}, {
    type = "Comma",
    pattern = "^,"
}, {
    type = "LBrace",
    pattern = "^{"
}, {
    type = "RBrace",
    pattern = "^}"
}, {
    type = "Equals",
    pattern = "^="
} }

function Parser:lex(input)
    local tokens = {}
    while #input > 0 do
        local matched = false
        for _, patt in ipairs(token_patterns) do
            local s, e = input:find(patt.pattern)
            if s then
                local value = input:sub(s, e)
                if patt.type ~= "Whitespace" then -- skip whitespace
                    table.insert(tokens, {
                        type = patt.type,
                        value = value
                    })
                end
                input = input:sub(e + 1)
                matched = true
                break
            end
        end
        if not matched then
            error("Unexpected token at: " .. input)
        end
    end
    return tokens
end

function Parser:new(input)
    local values = {}
    local tokens = self:lex(input)
    return setmetatable({
        tokens = tokens,
        pos = 1
    }, self)
end

function Parser:current()
    return self.tokens[self.pos]
end

function Parser:peek(offset)
    return self.tokens[self.pos + (offset or 1)]
end

function Parser:advance()
    self.pos = self.pos + 1
end

function Parser:expect(type, value)
    local token = self:current()
    if not token or token.type ~= type or (value and token.value ~= value) then
        error("Expected " .. type .. (value and (" '" .. value .. "'") or "") .. ", got " ..
            (token and token.type or "nil"))
    end
    self:advance()
    return token
end

function Parser:parse()
    return self:parse_expression()
end

function Parser:parse_expression()
    local token = self:current()
    local lefthand

    if not token then
        error("Unexpected end of input")
    end

    if token.type == "Number" then
        self:advance()
        lefthand = {
            type = "NumberLiteral",
            value = tonumber(token.value)
        }
    elseif token.type == "Identifier" then
        self:advance()
        lefthand = {
            type = "Identifier",
            value = token.value
        }
    elseif token.type == "Keyword" then
        self:advance()
        local str = self:expect("StringLiteral")
        self:expect("RParen")
        lefthand = {
            type = "KeywordIdentifier",
            value = str.value:sub(2, -2)
        }
    elseif token.type == "StringLiteral" then
        self:advance()
        lefthand = {
            type = "StringLiteral",
            value = token.value:sub(2, -2)
        }
    elseif token.type == "LParen" then
        self:advance()
        lefthand = {
            type = "Grouping",
            value = self:parse_expression()
        }
        self:expect("RParen")
    elseif token.type == "Operator" and token.value == "-" then
        self:advance()
        lefthand = {
            type = "Negation",
            value = self:parse_expression()
        }
    else
        error("Unexpected token: " .. token.type)
    end

    local op = self:current()
    if op == nil or op.type == "Comma" then
        return lefthand
    end

    if (op.type == "Assignment") then
        self:advance()
        local righthand = self:parse_expression()
        return {
            type = "Assignment",
            operator = op.value,
            left = lefthand,
            right = righthand
        }
    elseif (op.type == "LParen") then
        self:advance()
        local parameters = {}
        if (self:current() and self:current().type == "RParen") then
            return {
                type = "Call",
                value = lefthand,
                parameters = parameters
            }
        end

        local param = self:parse_expression()
        table.insert(parameters, param)

        while self:current() and self:current().type == "Comma" do
            self:advance()
            local param = self:parse_expression()
            table.insert(parameters, param)
        end
        self:expect("RParen")
        local call = {
            type = "Call",
            value = lefthand,
            parameters = parameters
        }
        lefthand = call
        if self:current() and self:current().type == "Operator" then
            op = self:current()
        end
    elseif (op.type == "LBrace") then
        self:advance()
        local assignments = {}
        if (self:current() and self:current().type == "RBrace") then
            return {
                type = "NoiseBlock",
                value = lefthand,
                assignments = assignments
            }
        end

        local assignment = self:parse_expression()
        table.insert(assignments, assignment)

        while self:current() and self:current().type == "Comma" do
            self:advance()
            local assignment = self:parse_expression()
            table.insert(assignments, assignment)
        end
        self:expect("RBrace")
        local noiseBlock = {
            type = "NoiseBlock",
            value = lefthand,
            assignments = assignments
        }
        lefthand = noiseBlock
        if self:current() and self:current().type == "Operator" then
            op = self:current()
        end
    end

    if (op.type == "Operator") then
        self:advance()
        local righthand = self:parse_expression()
        return {
            type = "BinaryOperation",
            operator = op.value,
            left = lefthand,
            right = righthand
        }
    end

    return lefthand
end

function Parser:replaceAllYInstancesWithAbsY(node, applyAbs)
    if not node then
        node = self:parse()
    end
    if node.type == "NumberLiteral" then
        return tostring(node.value)
    elseif node.type == "Negation" then
        return "-" .. self:replaceAllYInstancesWithAbsY(node.value)
    elseif node.type == "StringLiteral" then
        return "'" .. node.value .. "'"
    elseif node.type == "Identifier" then
        if applyAbs and node.value == "y" then
            return "abs_y"
        end
        return node.value
    elseif node.type == "KeywordIdentifier" then
        return "var('" .. node.value .. "')"
    elseif node.type == "Call" then
        local params = {}
        for _, param in ipairs(node.parameters) do
            table.insert(params, self:replaceAllYInstancesWithAbsY(param, true))
        end
        return node.value.value .. "(" .. table.concat(params, ", ") .. ")"
    elseif node.type == "NoiseBlock" then
        local fields = {}
        for _, v in pairs(node.assignments) do
            table.insert(fields, self:replaceAllYInstancesWithAbsY(v, true))
        end
        return node.value.value .. "{" .. table.concat(fields, ", ") .. "}"
    elseif node.type == "BinaryOperation" then
        return self:replaceAllYInstancesWithAbsY(node.left, true) ..
            " " .. node.operator .. " " .. self:replaceAllYInstancesWithAbsY(node.right, true)
    elseif node.type == "Assignment" then
        return self:replaceAllYInstancesWithAbsY(node.left, false) ..
            " " .. node.operator .. " " .. self:replaceAllYInstancesWithAbsY(node.right, true)
    elseif node.type == "Grouping" then
        return "(" .. self:replaceAllYInstancesWithAbsY(node.value) .. ")"
    else
        error("Unknown AST node type: " .. tostring(node.type))
    end
end

function Parser:replaceRandomPenalty(replacement, node)
    if not node then
        node = self:parse()
    end
    if node.type == "NumberLiteral" then
        return tostring(node.value)
    elseif node.type == "Negation" then
        return "-" .. self:replaceRandomPenalty(replacement, node.value)
    elseif node.type == "StringLiteral" then
        return "'" .. node.value .. "'"
    elseif node.type == "Identifier" then
        return node.value
    elseif node.type == "KeywordIdentifier" then
        return "var('" .. node.value .. "')"
    elseif node.type == "Call" then
        local params = {}
        for _, param in ipairs(node.parameters) do
            table.insert(params, self:replaceRandomPenalty(replacement, param))
        end
        return node.value.value .. "(" .. table.concat(params, ", ") .. ")"
    elseif node.type == "NoiseBlock" then
        if (node.value.value == "random_penalty") then
            return replacement
        end
        local fields = {}
        for _, v in pairs(node.assignments) do
            table.insert(fields, self:replaceRandomPenalty(replacement, v))
        end
        return node.value.value .. "{" .. table.concat(fields, ", ") .. "}"
    elseif node.type == "BinaryOperation" then
        return self:replaceRandomPenalty(replacement, node.left) ..
            " " .. node.operator .. " " .. self:replaceRandomPenalty(replacement, node.right)
    elseif node.type == "Assignment" then
        return self:replaceRandomPenalty(replacement, node.left) ..
            " " .. node.operator .. " " .. self:replaceRandomPenalty(replacement, node.right)
    elseif node.type == "Grouping" then
        return "(" .. self:replaceRandomPenalty(replacement, node.value) .. ")"
    else
        error("Unknown AST node type: " .. tostring(node.type))
    end
end

return Parser
