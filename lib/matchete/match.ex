defmodule Matchete.Match do
  alias Matchete.Queue
  defstruct ~w[size clients matcher]a

  def new(opts \\ []) do
    defaults = [size: 2, matcher: fn _req -> true end]
    opts = Keyword.merge(defaults, opts)

    %__MODULE__{
      size: Keyword.fetch!(opts, :size),
      clients: [],
      matcher: Keyword.fetch!(opts, :matcher)
    }
  end

  @doc """
  Searches queue for client and adds to clients list if found.
  """
  def maybe_add_client(match, queue) do
    case search_queue(match, queue) do
      :no_matches -> {match, queue}
      {:match, req, queue} -> {add_client(match, req), queue}
    end
  end

  defp search_queue(_match, []) do
    :no_matches
  end

  defp search_queue(match, queue) do
    search_queue(match, [], queue)
  end

  defp search_queue(match, searched, to_search) do
    if matches?(match, Queue.peek(to_search)) do
      {req, new_queue} = Queue.pop(to_search)
      {:match, req, searched ++ new_queue}
    else
      search_queue(match, searched ++ [hd(to_search)], tl(to_search))
    end
  end

  defp matches?(match, req) do
    match.matcher.(req)
  end

  def add_client(match, req) do
    Map.update(match, :clients, [], fn clients -> [req | clients] end)
  end
end
