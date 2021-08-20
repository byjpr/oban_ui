defmodule ObanUI.Timeago do
  @moduledoc false

  @minutes_in_year 525_600
  @minutes_in_quarter_year 131_400
  @minutes_in_three_quarters_year 394_200

  def time_ago_in_words(naive_date_time) do
    distance_of_time_in_words(naive_date_time, NaiveDateTime.utc_now())
  end

  def distance_of_time_in_words(from_ndt, to_ndt, opts \\ []) do
    duration =
      %{
        include_seconds: opts[:include_seconds],
        seconds: NaiveDateTime.diff(to_ndt, from_ndt)
      }
      |> maybe_convert_to_minutes
      |> maybe_convert_to_years(from_ndt, to_ndt)

    duration_in_words(duration)
  end

  defp maybe_convert_to_minutes(%{seconds: seconds}) when seconds > 59 do
    %{minutes: round(seconds / 60)}
  end

  defp maybe_convert_to_minutes(duration), do: duration

  defp maybe_convert_to_years(%{minutes: minutes}, from_ndt, to_ndt) when minutes > 525_599 do
    from_year = if from_ndt.month >= 3, do: from_ndt.year + 1, else: from_ndt.year
    to_year = if to_ndt.month < 3, do: to_ndt.year - 1, else: to_ndt.year

    leap_years =
      if from_year > to_year,
        do: 0,
        else: from_year..to_year |> Enum.count(&Calendar.ISO.leap_year?(&1))

    minute_offset_for_leap_year = leap_years * 1440
    # Discount the leap year days when calculating year distance.
    # e.g. if there are 20 leap year days between 2 dates having the same day
    # and month then the based on 365 days calculation
    # the distance in years will come out to over 80 years when in written
    # English it would read better as about 80 years.
    minutes_with_offset = minutes - minute_offset_for_leap_year

    %{
      remainder: rem(minutes_with_offset, @minutes_in_year),
      years: div(minutes_with_offset, @minutes_in_year)
    }
  end

  defp maybe_convert_to_years(duration, _from_ndt, _to_ndt), do: duration

  defp duration_in_words(%{include_seconds: true, seconds: seconds}) when seconds in 0..4 do
    translate_duration("less than %{count} seconds", count: 5)
  end

  defp duration_in_words(%{include_seconds: true, seconds: seconds}) when seconds in 5..9 do
    translate_duration("less than %{count} seconds", count: 10)
  end

  defp duration_in_words(%{include_seconds: true, seconds: seconds}) when seconds in 10..19 do
    translate_duration("less than %{count} seconds", count: 20)
  end

  defp duration_in_words(%{include_seconds: true, seconds: seconds}) when seconds in 20..39 do
    translate_duration("half a minute")
  end

  defp duration_in_words(%{include_seconds: true, seconds: seconds}) when seconds in 40..59 do
    translate_duration("less than a minute")
  end

  defp duration_in_words(%{seconds: seconds}) when seconds in 0..29 do
    translate_duration("less than a minute")
  end

  defp duration_in_words(%{seconds: seconds}) when seconds in 30..59 do
    translate_duration("1 minute")
  end

  defp duration_in_words(%{minutes: minutes}) when minutes == 1 do
    translate_duration("1 minute")
  end

  defp duration_in_words(%{minutes: minutes}) when minutes in 2..44 do
    translate_duration("%{count} minutes", count: minutes)
  end

  defp duration_in_words(%{minutes: minutes}) when minutes in 45..89 do
    translate_duration("about 1 hour")
  end

  # 90 mins up to 24 hours
  defp duration_in_words(%{minutes: minutes}) when minutes in 90..1439 do
    translate_duration("about %{count} hours", count: round(minutes / 60))
  end

  # 24 hours up to 42 hours
  defp duration_in_words(%{minutes: minutes}) when minutes in 1440..2519 do
    translate_duration("1 day")
  end

  # 42 hours up to 30 days
  defp duration_in_words(%{minutes: minutes}) when minutes in 2520..43_199 do
    translate_duration("%{count} days", count: round(minutes / 1440))
  end

  # 30 days up to 45 days
  defp duration_in_words(%{minutes: minutes}) when minutes in 43_200..64_799 do
    translate_duration("about 1 month")
  end

  # 45 days up to 60 days
  defp duration_in_words(%{minutes: minutes}) when minutes in 64_800..86_399 do
    translate_duration("about %{count} months", count: 2)
  end

  # 60 days up to 365 days
  defp duration_in_words(%{minutes: minutes}) when minutes in 86_400..525_599 do
    translate_duration("%{count} months", count: round(minutes / 43_200))
  end

  defp duration_in_words(%{remainder: remainder, years: years})
       when years == 1 and remainder < @minutes_in_quarter_year do
    translate_duration("about 1 year")
  end

  defp duration_in_words(%{remainder: remainder, years: years})
       when years == 1 and remainder < @minutes_in_three_quarters_year do
    translate_duration("over 1 year")
  end

  defp duration_in_words(%{remainder: remainder, years: years})
       when remainder < @minutes_in_quarter_year do
    translate_duration("about %{count} years", count: years)
  end

  defp duration_in_words(%{remainder: remainder, years: years})
       when remainder < @minutes_in_three_quarters_year do
    translate_duration("over %{count} years", count: years)
  end

  defp duration_in_words(%{years: years}) do
    translate_duration("almost %{count} years", count: years + 1)
  end

  defp translate_duration(msg, opts \\ []) do
    if count = opts[:count] do
      Gettext.dngettext(ObanUI.Gettext, "durations", msg, msg, count, opts)
    else
      Gettext.dgettext(ObanUI.Gettext, "durations", msg, opts)
    end
  end
end
