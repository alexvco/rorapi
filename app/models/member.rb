class Member < User
  self.table_name = 'users'
  default_scope { where(type: 'Member') }
end