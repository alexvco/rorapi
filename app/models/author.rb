class Author < User
  self.table_name = 'users'
  default_scope { where(type: 'Author') }
end