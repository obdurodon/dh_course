# Stooge SVG

David J. Birnbaum  
2020-04-06  

## Stooge XSL

* *stooge.xml* : Input data
* *stooge-dynamic.xsl* : XSLT to transform *stooge.xml*
* *stooge-dynamic.svg* : Output of transformation

This SVG is similar to what students create manually as a first SVG activity in our course, to familiarize themselves with the general SVG infrastructure, and with SVG rectangles, lines, and text. The files here illustrate how to use XSLT to perform the same task. The XSLT is commented for pedagogical purposes; please pose any questions by opening GitHub Issues in this repo.

## How `position()` works

* election\_2012\_data.xml : Input data
* how-position-works.xsl : XSLT to transform election data

Load the XML and XSLT into \<oXygen/\> and uncomment individual lines to see what they do. Within the template that matches the document node you can apply templates to all states, to states that begin with “O”, or to all nodes. Those nodes include whitespace nodes, which can lead to confusing `postion()` values when you process the states in the template that matches them.

This XSLT also shows how you can use `<xsl:message>` to output diagnostic information in a Messages window in the \<oXygen/\> debugger view, instead of writing it into your output, where, in Real Life, it could get lost in (and contaminate) an ocean of SVG output that isn’t really intended to be human-readable anyway.

