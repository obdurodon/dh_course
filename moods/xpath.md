# XPath over tokens

Find the number of speeches that contain each mood word

```
for $m in (//@mood ! tokenize(.)) => distinct-values() => sort()
return $m || ': ' || //sp[contains-token(@mood, $m)] => count() 
```