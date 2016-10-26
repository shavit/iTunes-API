defmodule ItunesApi do

  def build_url(params) do
    ['https://itunes.apple.com/search?api',
      Enum.map(params, fn({k,v}) -> "&"<>k<>"="<>v  end)
        |> List.to_string
    ]
      |> List.to_string
      |> String.to_charlist
  end

  def request(param_map) do
    :inets.start
    :ssl.start
    :httpc.request(:get, {build_url(param_map), []}, [], [])
  end

  def music(term, limit \\ "40") do
    %{
        "term" => term,
        "country" => "US",
        "media" => "music",
        # "entity" => "all",
        "limit" => limit,
        "lang" => "en_us",
        "explicit" => "yes"
    } |> request
  end
end
