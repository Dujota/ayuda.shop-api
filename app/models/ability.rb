# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new # guest user (not logged in)

    if !user.has_role? :admin
      # GUEST PERMISSIONS
      can :index, Listing

      # Signed in user Permissions
      if !user.new_record?
        # Aliases
        alias_action :my_listings, to: :manage_my_listings

        can :show, User, user_id: user.id
        can :read, Listing
        can :manage_my_listings, Listing
        can :read, Type
        can %i[create destroy update], Listing, user_id: user.id
      end

      if user.has_role? :content_editor
      end
    else
      can :manage, :all
    end

    # # GUEST
    # can :index, Listing

    # return unless

    # # ADMIN
    # return unless user.admin?
    # can :manage, :all
    # if !user.has_role? :admin
    #   can :index, Listing

    #   can :read, Type
    # else
    #   can :manage, :all
    # end
  end
end
