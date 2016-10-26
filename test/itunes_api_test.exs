defmodule ItunesApiTest do
  use ExUnit.Case
  doctest ItunesApi

  def params do
    %{
      "term" => "XO",
      "country" => "US",
      "media" => "all",
      # "entity" => "all",
      "limit" => "40",
      "lang" => "en_us",
      "explicit" => "yes"
    }
  end

  @doc """
  Should build a URL without any errors
  """
  test "build url" do
    assert ItunesApi.build_url(params) != None
  end

  @doc """
  Should make a successfull URL request
  """
  test "make an API request" do
    {:ok, {{_version, _code, _reason}, _headers, body}} = ItunesApi.request(params)
    assert %{"resultCount" => _result_count, "results" => results} = ItunesApi.parse(body)
    assert is_list(results)
  end

  test "search for music" do
    {:ok, {{_version, _code, _reason}, _headers, body}} =
      ItunesApi.request(Map.put(params, "media", "music"))

    assert body != None
  end

  test "search for podcast" do
    {:ok, {{_version, _code, _reason}, _headers, body}} =
      ItunesApi.request(Map.put(params, "media", "podcast"))

    assert body != None
  end
end
