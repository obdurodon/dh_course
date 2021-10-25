<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:let name="all-president-ids" value="doc('presidents.xml')//@xml:id"/>
  <sch:pattern>
    <sch:rule context="president">
      <sch:assert test="@ref = $all-president-ids">President <sch:value-of select="."/> does not
        have a @ref value that matches the @xml:id for a president.</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
