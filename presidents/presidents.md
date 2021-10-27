# XPath

1. Open (or create) project for presidents directory
1. Select all letter files (but not auxiliary files) in project view
1. Right-click and select “XPath in files”, which opens XPath builder

Now execute: 

```
//president[@ref = doc('presidents.xml')//@xml:id
[
(../@year-in ge '1800' and ../@year-in le '1900') 
or 
(../@year-out ge '1800' and ../@year-out le '1900')]
]
```

This selects all letters that contain a reference to a president who was in office in the nineteenth century (between 1800 and 1899).

How it works:

1. Find all `<president>` elements in all selected letters.
2. Filter themn according to the value of their `@ref` elements. The test will succeed only if there is a `@ref` value and it is equal to what we’re looking for.
3. Start a new path expression from the auxiliary *presidents.xml* document and compare the `@ref` values we found earlier to the `@xml:id` values in that auxiliary document. The `@ref` must match an `@xml:id` value in order for the `<president>` element we’re looking at to survive filtering and the `@xml:id` value it matches must satisfy certain requirements.
4. From any matching `@xml:id` value in the auxiliary document, look at its parent (which is an element of type `<president>`). 
5. Get the `@year-in` and `@year-out` attributes of any parent elements that made it this far and verify that either the `@year-in` or the `@year-out` is between '1800' and '1899'.

The preceding will select references to presidents in the letters only if the presidents were in offic in the nineteenth century. 

We do a string comparison, even though humans think of years as numbers, because element and attribute values selected in XML documents with XPath behave like strings by default. There are several ways to work around that behavior, and the one we employ here is to play along. This works only because we know that the years are all four digits long; for numbers of different length the comparison wouldn’t be reliable because, e.g., 11 is alphabetically less than 2.