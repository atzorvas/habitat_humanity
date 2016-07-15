require 'active_support/concern'
require 'csv'
require 'date_input'

##
# Contains an interface to limit the date range of a report.
#
module WeeklyReportable
  extend ActiveSupport::Concern

  included do
    # TODO: doesn't fit with the module name (allows for more control than just
    #       weekly reports); change module name?
    attr_reader :begin_date, :end_date
  end

  class_methods do
    ##
    # Returns a signatures report containing data for the week ending on the
    # specified end date
    #
    # @param ending [String,Date]
    #   Date or String parseable as a Date
    #
    # @return [SignaturesReport]
    def for_week(ending:)
      end_date   = ending.to_date
      begin_date = end_date - 6.days
      new_with_date_range(begin_date, end_date)
    end

    ##
    # Returns a signatures report containing data for the specified date range
    #
    # @param beginning [String,Date]
    #   Date or String parseable as a Date
    #
    # @param ending [String,Date]
    #   Date or String parseable as a Date
    #
    # @return [SignaturesReport]
    def for_date_range(beginning:, ending:)
      new_with_date_range(beginning, ending)
    end

    private

    def new_with_date_range(begin_date, end_date)
      report = new
      report.set_date_range(begin_date, end_date)
      report
    end
  end

  ##
  # Sets the begin/end date ivars to the specified begin/end dates
  def set_date_range(begin_date, end_date)
    @begin_date = begin_date.to_date
    @end_date   = end_date.to_date
  end
end
