# DO NOT EDIT THIS FILE.  This file is automatically regenerated as needed.
class Role < ApplicationRecord

  belongs_to :actor, optional: true
  belongs_to :movie, optional: true
  belongs_to :agent, optional: true

end