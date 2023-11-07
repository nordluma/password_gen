defmodule PasswordGenTest do
  use ExUnit.Case

  setup do
    options = %{
      "length" => "10",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "false"
    }

    options_type = %{
      lowercase: Enum.map(?a..?z, &<<&1>>),
      numbers: Enum.map(0..9, &Integer.to_string(&1)),
      uppercase: Enum.map(?A..?Z, &<<&1>>),
      symbols: String.split("!#$%&()*+,-./:;<=>?@[]^_{}|~", "", trim: true)
    }

    {:ok, result} = PasswordGen.generate(options)

    %{
      options_type: options_type,
      result: result
    }
  end

  test "returns a string", %{result: result} do
    assert is_bitstring(result)
  end

  test "returns error when no length is given" do
    options = %{"invalid" => "false"}

    assert {:error, _error} = PasswordGen.generate(options)
  end

  test "returns error when length is not an integer" do
    options = %{"length" => "abc"}

    assert {:error, _error} = PasswordGen.generate(options)
  end

  test "length of returned string is the same as in the passed option" do
    length_option = %{"length" => "5"}
    {:ok, result} = PasswordGen.generate(length_option)

    assert 5 = String.length(result)
  end

  test "return a lowercase string with the length", %{options_type: options} do
    length_option = %{"length" => "5"}
    {:ok, result} = PasswordGen.generate(length_option)

    assert String.contains?(result, options.lowercase)

    refute String.contains?(result, options.numbers)
    refute String.contains?(result, options.uppercase)
    refute String.contains?(result, options.symbols)
  end

  test "returns error when option values are not booleans" do
    options = %{
      "length" => "10",
      "numbers" => "invalid",
      "uppercase" => "0",
      "symbols" => "false"
    }

    assert {:error, _error} = PasswordGen.generate(options)
  end

  test "returns error when passing invalid option" do
    options = %{
      "lenght" => "5",
      "invalid" => "true"
    }

    assert {:error, _error} = PasswordGen.generate(options)
  end

  test "returns error when 1 option is invalid" do
    options = %{
      "length" => "5",
      "numbers" => "true",
      "invalid" => "true"
    }

    assert {:error, _error} = PasswordGen.generate(options)
  end

  test "returns string with uppercase", %{options_type: options} do
    options_with_uppercase = %{
      "length" => "10",
      "numbers" => "false",
      "uppercase" => "true",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGen.generate(options_with_uppercase)

    assert String.contains?(result, options.uppercase)

    refute String.contains?(result, options.numbers)
    refute String.contains?(result, options.symbols)
  end

  test "returns string with just containing numbers", %{options_type: options} do
    options_with_numbers = %{
      "length" => "10",
      "numbers" => "true",
      "uppercase" => "false",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGen.generate(options_with_numbers)

    assert String.contains?(result, options.numbers)

    refute String.contains?(result, options.symbols)
    refute String.contains?(result, options.uppercase)
  end

  test "returns string with uppercase and numbers", %{options_type: options} do
    options_included = %{
      "length" => "10",
      "numbers" => "true",
      "uppercase" => "true",
      "symbols" => "false"
    }

    {:ok, result} = PasswordGen.generate(options_included)

    assert String.contains?(result, options.uppercase)
    assert String.contains?(result, options.numbers)

    refute String.contains?(result, options.symbols)
  end

  test "returns string with symbols", %{options_type: options} do
    options_included = %{
      "length" => "10",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGen.generate(options_included)

    assert String.contains?(result, options.symbols)

    refute String.contains?(result, options.uppercase)
    refute String.contains?(result, options.numbers)
  end

  test "returns string including all options", %{options_type: options} do
    options_included = %{
      "length" => "10",
      "numbers" => "true",
      "uppercase" => "true",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGen.generate(options_included)

    assert String.contains?(result, options.symbols)
    assert String.contains?(result, options.uppercase)
    assert String.contains?(result, options.numbers)
  end

  test "returns string with symbols and uppercase", %{options_type: options} do
    options_included = %{
      "length" => "10",
      "numbers" => "false",
      "uppercase" => "true",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGen.generate(options_included)

    assert String.contains?(result, options.symbols)
    assert String.contains?(result, options.uppercase)

    refute String.contains?(result, options.numbers)
  end

  test "returns string with symbols and numbers", %{options_type: options} do
    options_included = %{
      "length" => "10",
      "numbers" => "true",
      "uppercase" => "false",
      "symbols" => "true"
    }

    {:ok, result} = PasswordGen.generate(options_included)

    assert String.contains?(result, options.symbols)
    assert String.contains?(result, options.numbers)

    refute String.contains?(result, options.uppercase)
  end
end
