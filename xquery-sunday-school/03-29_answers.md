# Sunday, March 29 answers

## Activites with a single play (*Hamlet*)

### All acts in *Hamlet* 

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:text/tei:body/tei:div/tei:div
```

### All scenes in *Hamlet*

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:text/tei:body/tei:div/tei:div/tei:div
```

### All scenes in Act 3 of *Hamlet*

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:text/tei:body/tei:div/tei:div[3]/tei:div
```

### All stage directions that are not descendants of speeches

Do not ask for stage directions that are children of scenes because you don’t know what their parents are. Ask for stage directions that are not descendants of speeches.

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:stage[not(ancestor::tei:sp)]
```

### The parents of all stage directions that are not descendants of speeches

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:stage[not(ancestor::tei:sp)]/..
```

### The element names of all parents of all stage directions that are not descendants of speeches

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:stage[not(ancestor::tei:sp)]/.. ! name()
```

### The *distinct* names of all parents of all stage directions that are not descendants of speeches

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:stage[not(ancestor::tei:sp)]/.. ! name() => distinct-values()
```

### All speeches by Hamlet

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham']
```

### The number of speeches by Hamlet

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham'] => count()
```

### The length of all speeches by Hamlet in line count

Count of `<l>` children of the `<sp>` speech element. Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham'] ! count(tei:l)
```

### The length of Hamlet’s longest speech

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham'] ! count(tei:l) => max()
```

### Hamlet’s longest speech

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham']
	[count(tei:l) = 
    doc('/db/apps/shakespeare-pm/data/F-ham.xml')//tei:sp[@who eq '#F-ham-ham'] ! count(tei:l) => max()
    ]
```

### Activities within a collection (all Shakespeare plays)

#### All files in the *data* subcollection of the Shakespeare app

One of these files is not a play; we’ll ignore that for now.

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')
```

#### Number of plays

Builds on the preceding

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data') => count()
```

#### All speeches in each play

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')/descendant::tei:sp
```

#### Count of speeches in each play (builds on the preceding)

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data')/count(descendant::tei:sp)
```

or

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare-pm/data') ! (descendant::tei:sp => count())
```