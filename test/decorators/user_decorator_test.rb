# frozen_string_literal: true

require "test_helper"

class UserDecoratorTest < ActiveSupport::TestCase
  def setup
    @user1 = ActiveDecorator::Decorator.instance.decorate(users(:komagata))
    @user2 = ActiveDecorator::Decorator.instance.decorate(users(:hajime))
  end

  test "#staff_roles" do
    assert_equal "管理者、メンター", @user1.staff_roles
    assert_equal "", @user2.staff_roles
  end

  test "#icon_title" do
    assert_equal "komagata: 管理者、メンター", @user1.icon_title
    assert_equal "hajime", @user2.icon_title
  end

  test "#niconico_calendar" do
    days_in_weeks = 7
    assert_equal days_in_weeks, @user2.niconico_calendar.first.count
  end

  test "#twitter_url" do
    assert_equal "https://twitter.com/komagata", @user1.twitter_url
    assert_equal "https://twitter.com/hajime", @user2.twitter_url
  end

  test "#github_url" do
    assert_equal "https://github.com/komagata", @user1.github_url
    assert_equal "", @user2.github_url
  end
end
