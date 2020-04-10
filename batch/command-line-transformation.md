# Batch XSLT from the command line

You need Java to run Saxon. You can test whether it is installed with `java -version`. If you get an error message, install Java 8 from <https://adoptopenjdk.net/>.

Download and install Saxon HE from the link at <https://saxonica.com>. After you unzip the file, the transformation is performed by *saxon-he-10.0.jar*. 

Once Java is installed and you have downloaded Saxon, you can run Saxon with:

```bash
java -jar /opt/saxon/he/saxon-he-10.0.jar
```

*Important:* This is the path to where I’ve installed Saxon on my system. You need to replace the filesystem path to the location where you have put *saxon-he-10.0.jar* on your system.

Command-line Saxon takes several arguments, the most important of which are below. The arguments can be in any order, but there must be no spaces:

* `-s:myInput.xml` Transform a single file called *myInput.xml* in the current working directory where I am running Saxon. If the file is elsewhere, give the full path. To batch transform multiple XML input files, put them in a directory with nothing else and specify the directory name (or path, if necessary) as the value of the `-s:` switch, instead of a filename.
* `-xsl:myScript.xsl` Use an XSLT stylesheet called *myScript.xsl* to perform the transformation.
* `-o:myOutput.xml` Save the output of the transformation to a file called *myOutput.xml* (or path, if necessary). If the input is a directory, and not a single file, the output must be a directory, and vice versa.

If you are not specifying any input files (because, for example, you are obtaining the input with `doc()` or `collection()` functions inside the XSLT), you must include the `-it` switch on the command line. This means “initial template”, and it tells Saxon to start the transformation with a template inside the XSLT that has the `@name` value of “xsl:initial-template”, and not to expect an input file or directory to be specified with the `-s:` switch.

Specifying an output file or directory with `-o:` is optional. If you are not writing any output to stdout (for example, if all of your output is being controlled with `<xsl:result-document>`, you should omit the `-o:` switch, since there is no output for it to control. If you are creating normal output and don’t specify a value, the output will be written to the screen. This may be useful for debugging, but in Real Life you’ll probably want to save the output to disk.