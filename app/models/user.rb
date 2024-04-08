# frozen_string_literal: true

# Public: User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  encrypts :email, deterministic: true, downcase: true

  has_many :workspace_checklists, as: :assignee, class_name: 'Workspace::Checklist', dependent: :destroy

  after_create :setup_workspace

  private

  def setup_workspace = Workspace::Setup.call(self)
end
