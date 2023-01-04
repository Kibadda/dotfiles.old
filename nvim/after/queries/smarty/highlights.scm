(tag_name) @tag
(erroneous_end_tag_name) @error
(comment) @comment
(attribute_name) @tag.attribute
(attribute
  (quoted_attribute_value) @string)
(text) @text
(doctype) @constant

((element (start_tag (tag_name) @_tag) (text) @text.title)
 (#match? @_tag "^(h[0-9]|title)$"))

((element (start_tag (tag_name) @_tag) (text) @text.strong)
 (#match? @_tag "^(strong|b)$"))

((element (start_tag (tag_name) @_tag) (text) @text.emphasis)
 (#match? @_tag "^(em|i)$"))

((element (start_tag (tag_name) @_tag) (text) @text.strike)
 (#match? @_tag "^(s|del)$"))

((element (start_tag (tag_name) @_tag) (text) @text.underline)
 (#eq? @_tag "u"))

((element (start_tag (tag_name) @_tag) (text) @text.literal)
 (#match? @_tag "^(code|kbd)$"))

((element (start_tag (tag_name) @_tag) (text) @text.uri)
 (#eq? @_tag "a"))

((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @text.uri))
 (#match? @_attr "^(href|src)$"))

(smarty
  (smarty_translation
    (text) @string))

(smarty_attribute
  (quoted_attribute_value) @string)

(smarty_attribute
  (bracket_attribute_value
    (quoted_attribute_value) @string))

(smarty_attribute
  (attribute_value) @string)

(smarty_value) @string

(smarty_inline) @tag.delimiter

(smarty_comment) @comment

[
 "<"
 ">"
 "</"
 "/>"
 "}"
 "{"
 "{if"
 "{/if}"
 "{else}"
 ; "{elseif"
 "{foreach"
 "{/foreach}"
 "{generate"
 "{include"
 "{t"
 "{literal}"
 "{/literal}"
 "{/t}"
 "<!"
 "=>"
] @tag.delimiter

"=" @operator
