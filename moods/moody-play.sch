<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:pattern>
    <sch:rule context="@mood">
      <!-- TODO extract token list into variable to avoid repetition -->
      <!-- TODO merge @who and @mood rules -->
      <sch:assert test="count(tokenize(.)) eq count(distinct-values(tokenize(.)))">@mood value
        cannot be repeated on a speech</sch:assert>
      <sch:report test="count(tokenize(.)) gt 5" role="warning">More than 5 @mood
        values</sch:report>
    </sch:rule>
    <sch:rule context="@who">
      <!-- TODO extract token list into variable to avoid repetition -->
      <!-- TODO merge @who and @mood rules -->
      <sch:assert test="count(tokenize(.)) eq count(distinct-values(tokenize(.)))">@who value cannot
        be repeated on a speech</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
