module IceCube

  module Validations::DayOfYear

    def day_of_year(*days)
      days.each do |day|
        validations_for(:day_of_year) << Validation.new(day)
      end
      clobber_base_validations(:month, :day, :wday)
      self
    end

    class Validation

      attr_reader :day

      def initialize(day)
        @day = day
      end

      def type
        :day
      end

      def validate(time, schedule)
        days_in_year = TimeUtil.days_in_year(time)
        the_day = day < 0 ? day + days_in_year : day
        # compute the diff
        diff = the_day - time.yday
        diff >= 0 ? diff : diff + days_in_year
      end

    end

  end

end
