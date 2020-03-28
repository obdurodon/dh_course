# XQuery Sunday School

## Course synopsis

During the spring 2020 semester the University of Pittsburgh “Computational methods in the humanities” course will run an optional XQuery Sunday School. The class will meet three times on Zoom at the usual course URL (see the CourseWeb announcement) at 1:00 p.m. The syllabus is:

1. Sunday, March 29: Installation, the eXist-db interface, XPath in XQuery, XQuery declarations
2. Sunday, April 5: FLWOR expressions
3. Sunday, April 12: Uploading data, putting it all together

These teaching materials are based on <https://ebeshero.github.io/UpTransformation/schedule.html> (Elisa Beshero-Bondar and David J. Birnbaum). For links to other XQuery and related resources see our <https://ebeshero.github.io/UpTransformation/References.html>,

## Sunday, March 29

### Getting started

* Install eXist-db from <https://exist-db.org>. If eXist-db prompts you to install Java, follow the instructions; if it doesn’t, you probably already have Java installed.
* Launch eXist-db, explore dashboard and launcher
* Package manager, install Shakespeare project (TEI Publisher version)
* Launch Shakespeare from launcher
* Launch eXide from launcher; first XQuery code

### XPath in XQuery

Basic XPath expressions: strings, arithmetic, functions (`string-length('hamlet')`)

### Accessing collections and resources

* Collections: `collection('/db/apps/shakespeare-pm/data')`
* Resources: `doc('/db/apps/shakespeare-pm/data/F-ham.xml')`

### Namespace declarations

* Declarations must come first, and must end in semicolons.  
* Statements other than declarations do not end in semicolons.

All stage directions in one play:

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:stage
```

All stage directions in all plays:

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')//tei:stage
```
### Applying functions to nodes to return atomic values

#### Mapping operations and the *simple map operator* (`!`)

The XPath expression `collection('/db/apps/shakespeare-pm/data')//tei:stage` return the `<stage>` element nodes; note the tags and namespace declarations. You can use the `string()` function to strip the markup and return just the text; what `string()` does is take something as input and return its string value, that is, its value with markup stripped. 

You can apply a function to a sequence of nodes in two ways. This application of a function to a sequence of inputs is sometimes called *mapping*, because we *map* a sequence of inputs (e.g., nodes) to outputs (e.g., atomic values derived from each node by applying a function).

The old way of mapping uses the `/` operator:

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')//tei:stage/string()
```

This says (reading from left to right): find all documents in the specified location (which is all the Shakespeare plays in TEI XML), get all of their descendant `<stage>` elements, and, for each `<stage>` element, strip its markup and return just its string value, that is, just its text.

The new (since XPath 3.0) way of doing the same thing uses the *simple map operator* (`!`):

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')//tei:stage ! string()
```

These are equivalent in this context. There are some differences between using the `/` and `!` operators, which we’ll discuss when they become relevant.

#### The *arrow operator* (`=>`)

The *arrow operator* (`=>`) applies a function to an entire input sequence at once and produces a single output. Compare the example above (reproduced here):

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')//tei:stage ! string()
```

The simple map operator produces one string value for each `<stage>` element in the collection. It maps between a sequence of input items (`<stage>` elements) to a sequence of output items (string values), producing one output item for each input item.

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')//tei:stage => count()
```

The arrow operator takes the entire sequence to the left (a sequence of `<stage>` elements) and uses it as the input to the function on the right. Since counting a sequence produces a single integer output, equal to the number of items in the input sequence, this produces the same result as:

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
count(collection('/db/apps/shakespeare-pm/data')//tei:stage)
```

We find the arrow operator easier to read than wrapping `count()` around its argument in situations like this, but they are equivalent, and neither is better or worse than the other.

### Declaring variables

* Variables declared with `declare variable` are available in the entire XQuery script
* Variable declarations, like namespace declarations, come before other code and end in a semicolon

#### Syntax of variable declarations

Variable declarations have six parts, in order (see the first example below):

1. The magic incantation `declare variable`
1. A variable name, specified with a leading dollar sign (this is difference from the way variables are declared in XSLT). In the first example below, this is `$plays`.
1. A datatype specification, which takes the form `as` followed by the datatype, using the same repetition indiators as regex. In the first example below, `as element(tei:TEI)*` says that the variable will consist of zero or more elements of type `<TEI>` in the TEI namespace. As is the case with XSLT, the datatype specification is technically not required, but, as with XSLT, pretend it is, since omitting it is asking for trouble.
2. The assignment operator. *This is not an equal sign;* it is a colon followed by an equal sign (`:=`). This is sometimes called the *walrus operator* (because it looks like walrus eyes and tusks, tipped sideways).
3. The value of the variable. In the first example below, it is the `<TEI>` root elements of all documents in the *data* subdirectory of the *shakespeare-pm* app.
4. A trailing semicolon. All declarations in XQuery end in a semicolon. No other statements in XQuery end in a semicolon.

#### Variable for elements (example)

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $plays as element(tei:TEI)* := 
	collection('/db/apps/shakespeare-pm/data')/tei:TEI;
count($plays)
```

#### Variable for resources (documents; example)

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $plays as document-node()* := 
	collection('/db/apps/shakespeare-pm/data');
count($plays)
```

#### Variable for atomic values (example)

`xs:string`, `xs:integer`, `xs:double`

```xquery
declare variable $university as xs:string := 'University of Pittsburgh';
string-length($university)
```

### Practice

These examples are for practice. We’ll post the solutions in a separate document, and some of them are challenging, but try them yourselves first before looking up the answer.

Using `doc('/db/apps/shakespeare-pm/data/F-ham.xml')` to point to the document node of the *Hamlet* resource in the database, find the following by using regular XPath expressions. Don’t forget that you need to include a namespace declaration for the TEI namespace (you can copy and paste it from this document). 

#### About our sample document

The markup in the edition of *Hamlet* included in the database differs in several important ways from the *Bad Hamlet* file we used previously. You can view the entire file by running `doc('/db/apps/shakespeare-pm/data/F-ham.xml')` and scroll along to see the details below:

1. It has an extra `<div>` between the `< body>` and the acts. For example, in our earlier *Bad Hamlet*, you could find acts with `//body/div`. In this version you need `doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:body/tei:div/tei:div`.
2. The values of the `@who` attributes on `<sp>` elements that hold the speaker names are different. The only character whose name we will look for is Hamlet, and his value is `#F-ham-ham` (not just `ham`, as was the case in *Bad Hamlet*).
3. *Bad Hamlet* represented non-metrical lines with `<ab>` (TEI ‘anonymous block’) elements, while the version inside eXist-db uses `<p>` elements. We’re going to ignore these for now, so when we ask for information about lines, all we care about is `<l>` elements.

XPath in eXist-db has two important differences from the way we’ve used XPath in \<oXygen/\>. These are:

1. In XQuery the path must start with `collection()` or `doc()`. It cannot start with just a slash or double slash. This is because in eXist-db the database holds multiple documents and you have to tell it which one(s) you care about, while in XSLT you have always had a single input document that was necessarily the context.
2. In XQuery you must use the `tei:` prefix for *all* elements in the TEI namespace (all of them, at every path step).

Otherwise the markup is the same, so scenes are `<div>` children of acts, speeches are `<sp>` children of scenes, stage directions are `<stage>`, etc.

#### Activities with a single play (*Hamlet*)

These expression all have to begin with the `doc()` function, with the path to *Hamlet* as its argument. See above for details.

1. All acts in *Hamlet* (the answer to this one is above)
2. All scenes in *Hamlet*
3. All scenes in Act 3 of *Hamlet*. (builds on the preceding)
4. All stage directions that are not descendants of speeches. (Do not ask for stage directions that are children of scenes because you don’t know what their parents are. Ask for stage directions that are not descendants of speeches.)
5. The parents of all stage directions that are not descendants of speeches. (builds on the preceding)
6. The element names of all parents of all stage directions that are not descendants of speeches. (builds on the preceding)
7. The *distinct* names of all parents of all stage directions that are not descendants of speeches. (builds on the preceding)
8. All speeches by Hamlet
6. The number of speeches by Hamlet (builds on the preceding)
7. The length of all speeches by Hamlet in line count (count of `<l>` children of the `<sp>` speech element. (builds on the preceding)
8. The length of Hamlet’s longest speech (builds on the preceding)
9. Hamlet’s longest speech (builds on the preceding)

These are taken from our original XPath exercises, the answer to which are in files linked from the XPath section of our main course page.

#### Activities within a collection (all Shakespeare plays)

These expressions all have to being with the `collection()` function, with the path to the collections that holds all of the Shakespeare plays as its argument. See above for details. The title of each play in these editions is located at `/TEI/text/body/div/head`.

1. All files in the *data* subcollection of the Shakespeare app. (One of these files is not a play; we’ll ignore that for now.)
2. Number of plays (builds on the preceding)
2. All speeches in each play
3. Count of speeches in each play (builds on the preceding)
