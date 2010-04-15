@spork
Feature:  https://rspec.lighthouseapp.com/projects/16211/tickets/597
  As a RubyMine user who likes Cucumber, Spork and Rails
  I want RubyMine's nice GUI test runner to work with cucumber

  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/support/env.rb" with:
      """
      require 'rubygems'
      require 'spork'

      Spork.prefork do
        puts "I'm loading all the heavy stuff..."
      end

      Spork.each_run do
        puts "I'm loading the stuff just for this run..."
      end
      """
    And a file named "features/step_definitions/some_step.rb" with:
    """
    Given /^I have some cukes$/ do
    end
    """
    And a file named "features/f.feature" with:
      """
      Feature: F
        Scenario: S
          Given I have some cukes
      """
    And the following profile is defined:
    """
    default: --strict --format progress
    """

  Scenario: Pass formatter two times without Spork Drb
    When I run cucumber -q --format progress features/f.feature
    Then STDERR should be empty
    And it should pass

  Scenario: Pass formatter two times using Spork Drb
    Given I am running spork in the background on port 9000
    When I run cucumber -q  --drb --port 9000 --format progress features/f.feature
    Then STDERR should be empty
    And it should pass
