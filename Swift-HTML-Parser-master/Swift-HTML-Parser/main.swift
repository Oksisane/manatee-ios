import Foundation

// sample HTML
let html =
"<html>" +
"<head>" +
"</head>" +
"<body>" +
"  <span class='spantext'>" +
"    <b>Hello World 1</b>" +
"  </span>" +
"  <span class='spantext'>" +
"    <b>Hello World 2</b>" +
"  </span>" +
"  <a href='example.com'>example(English)</a>" +
"  <a href='example.co.jp'>example(JP)</a>" +
"  <div class='val'>value1</div>" +
"  <div class='val'>value2</div>" +
"  <div class='box'>" +
"    <span class='dat'>" +
"      <strong content='2014-12-31'>2014/12/31</strong>" +
"    </span>" +
"    <h2>Hoge</h2>" +
"  </div>" +
    "  <table>" +
    "    <tr><td>a0</td><td>b0</td></tr>" +
    "    <tr><td>a1</td><td>b1</td></tr>" +
    "    <tr><td>a2</td><td>b2</td></tr>" +
    "    <tr><td>a3</td><td>b3</td></tr>" +
    "    <tr><td>a4</td><td>b4</td></tr>" +
    "    <tr><td>a5</td><td>b5</td></tr>" +
    "    <tr><td>a6</td><td>b6</td></tr>" +
    "    <tr><td>a7</td><td>b7</td></tr>" +
    "    <tr><td>a8</td><td>b8</td></tr>" +
    "    <tr><td>a9</td><td>b9</td></tr>" +
    "  </table>" +
    "<a href='mailto:test1'>abc</a>" +
    "<a href='mailto:test2'>abc</a>" +
    "<a href='mailto:test3'>abc</a>" +
    "<a href='mailto:test4'>abc</a>" +
"</body>" +
"</html>"


var err : NSError?
let option = CInt(HTML_PARSE_NOERROR.rawValue | HTML_PARSE_RECOVER.rawValue)
var parser     = HTMLParser(html: html, encoding: NSUTF8StringEncoding, option: option, error: &err)
if err != nil {
    print(err)
    exit(1)
}

var bodyNode   = parser.body

if let inputNodes = bodyNode?.findChildTags("b") {
    for node in inputNodes {
        print("Contents: \(node.contents)")
        print("Raw contents: \(node.rawContents)")
    }
}

if let inputNodes = bodyNode?.findChildTags("a") {
    for node in inputNodes {
        print("Contents: \(node.contents)")
        print("Raw contents: \(node.rawContents)")
        print(node.getAttributeNamed("href"))
    }
}

print(bodyNode?.findChildTagAttr("div", attrName: "class", attrValue: "val")?.contents)

if let inputNodes = bodyNode?.findChildTagsAttr("div", attrName: "class", attrValue: "val") {
    for node in inputNodes {
        print("Contents: \(node.contents)")
        print("Raw contents: \(node.rawContents)")
    }
}


if let path = bodyNode?.xpath("//div[@class='box']") {
    for node in path {
        print(node.tagName)
        print(node.xpath("//h2")?[0].contents)
    }
}

if let nodes = bodyNode?.css("tr:nth-child(2) :nth-child(1)") {
    for node in nodes {
        print(node.contents)
    }
}

if let nodes = bodyNode?.css("tr") {
    for node in nodes {
        if let tdNode = node.css("td") {
            print(tdNode.first?.contents)
        }
    }
}

