class PhotoPolicy < ApplicationPolicy
	def edit?
	  user == record.user
	end
  end