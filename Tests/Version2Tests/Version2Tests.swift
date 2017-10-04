import XCTest
@testable import Version2

class Version2Tests: XCTestCase {
    let markdown = Markdown()
    
    func testText() {
        let md = """
        Hello World!
        This is just text for know
        """
        
        let html = """
        Hello World!
        This is just text for know
        """
        
        XCTAssertEqual(try markdown.render(md), html)
    }
    
    func testEscape() {
        let md = """
        \\### Header Two with Hash

        \\# Hello World!
        This is just text for know
        \\- Caleb Kleveter
        """
        
        let html = """
        ### Header Two with Hash

        # Hello World!
        This is just text for know
        - Caleb Kleveter
        """
        
        XCTAssertEqual(try markdown.render(md), html)
    }
    
    func testHeaderOne() {
        let md = """
        \\# Hello World!
        # Header 1

        Header Goes Here
        ===
        
        # Hashes ### HASHES ## everywhere ##

        # Header Again #
        """
        
        let html = """
        # Hello World!
        <h1>Header 1</h1>

        <h1>Header Goes Here</h1>

        <h1>Hashes ### HASHES ## everywhere</h1>

        <h1>Header Again</h1>
        """
        
        XCTAssertEqual(try markdown.render(md), html)
    }
    
    func testHeaderTwo() {
        let md = """
        \\#\\# Hello World!
        ## Header 2

        ## Broken # header

        Header Goes Here
        ---

        ## \\# Header Hash with Two
        """
        
        let html = """
        ## Hello World!
        <h2>Header 2</h2>

        <h2>Broken # header</h2>

        <h2>Header Goes Here</h2>

        <h2># Header Hash with Two</h2>
        """
        
        XCTAssertEqual(try markdown.render(md), html)
    }
    
    static var allTests : [(String, (Version2Tests) -> () throws -> Void)] {
        return [
            ("testText", testText),
            ("testEscape", testEscape),
            ("testHeaderOne", testHeaderOne),
            ("testHeaderTwo", testHeaderTwo)
        ]
    }
}
