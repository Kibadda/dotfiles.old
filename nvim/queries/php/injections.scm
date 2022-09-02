(
 (expression_statement
   (assignment_expression
     left: (variable_name (name) @_name)
     right: [
       (encapsed_string (string_value) @sql)
       (string (string_value) @sql)
     ]))
 (#eq? @_name "sqlString")
)
