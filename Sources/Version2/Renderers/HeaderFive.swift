//The MIT License (MIT)
//
//Copyright (c) 2017 Caleb Kleveter
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

public class HeaderFive: Renderer {
    public var regex: RegEx = "#{5}\\s+(.+?)(?m:([[:blank:]]#*[[:blank:]]*$|$))"
    public var templates: [String] = ["$1"]
    public var type: String = "header"
    public var disallowedTags: [String] = ["header", "quote", "image", "hr"]
    public var renderer: MarkdownRenderer = Markdown()
    
    public required init() {
        renderer.disallowedTags = disallowedTags
    }
    
    public func tokenize(_ strings: [String])throws -> Token {
        let internalTokens = try renderer.tokenize(strings[0])
        return HeaderFiveToken(value: internalTokens)
    }
    
    public func parse(_ token: Token)throws -> Node {
        guard case let TokenValue.array(tokens) = token.value else {
            throw HeaderFiveRenderingError.tokenParse
        }
        let internalNodes = try self.renderer.parse(tokens)
        return HeaderFiveNode(value: internalNodes)
    }
    
    public func render(_ node: Node)throws -> String {
        guard case let NodeValue.array(nodes) = node.value else {
            throw HeaderFiveRenderingError.nodeRender
        }
        let internalHTML = try self.renderer.render(nodes)
        return "<h5>\(internalHTML)</h5>"
    }
    
    
}

public class HeaderFiveToken: Token {
    public var renderer: Renderer.Type = HeaderFive.self
    public var value: TokenValue
    
    public init(value: [Token]) {
        self.value = .array(value)
    }
}

public class HeaderFiveNode: Node {
    public var renderer: Renderer.Type = HeaderFive.self
    public var value: NodeValue
    
    public init(value: [Node]) {
        self.value = .array(value)
    }
}

public enum HeaderFiveRenderingError: Error {
    case tokenParse
    case nodeRender
}

