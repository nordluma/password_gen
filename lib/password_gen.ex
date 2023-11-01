defmodule PasswordGen do
  @moduledoc """
  Generates a random password depending on the passed parameters. The modules
  main func is `generate(options)`, the function takes a map with options as a
  parameter.

  ## Options example:
    options = %{
      "length" => "5",
      "numbers" => "false",
      "uppercase" => "false",
      "uppercase" => "false"
    }
  The option has 4 values, `length`, `numbers`, `uppercase` and `symbols`.
  """

  @allowed_options [:length, :numbers, :uppercase, :symbols]

  @doc """
  Generates a password for given options:

  ## Examples
      options = %{
        "lenght" => "5",
        "numbers" => "false",
        "uppercase" => "false",
        "symbols" => "false"
      }

      iex> PasswordGen.generate(options)
      "abcde"

      options = %{
        "lenght" => "5",
        "numbers" => "true",
        "uppercase" => "false",
        "symbols" => "false"
      }

      iex> PasswordGen.generate(options)
      "abcd4"
  """

  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    validate_length(length, options)
  end
  end
end
