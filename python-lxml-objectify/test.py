# Tested with Python 2.7
#   => http://lxml.de/objectify.html
#   => http://www.blog.pythonlibrary.org/2012/06/06/parsing-xml-with-python-using-lxml-objectify
import sys
from lxml import etree, objectify

def objectifyXML(filepath):
    # Read XML as string
    xml = open(filepath, 'r').read()
    print("XML: " + str(xml))
    # Parse XML data
    root = objectify.fromstring(xml)
    print("Parsed object: " + objectify.dump(root))
    
    # loop over elements and print their tags, attribs and sub-elements
    for e in root.iterchildren():
        print "%s(%s) => %s" % (e.tag, e.attrib, e.__dict__)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Must specify an XML file to parse...")
        exit()
    objectifyXML(sys.argv[1])
