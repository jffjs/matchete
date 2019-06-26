defmodule Matchete.Queue do
  @doc """
  Push item to back of queue

  ## Examples

      iex> q = Matchete.Queue.push([], 1)
      [1]
      iex> Matchete.Queue.push(q, 2)
      [1, 2]

  """
  def push(q, item) when is_list(q), do: q ++ [item]

  @doc """
  Removes and returns first item from queue.

  ## Examples

      iex> Matchete.Queue.pop([1, 2])
      {1, [2]}
      iex> Matchete.Queue.pop([])
      {nil, []}

  """
  def pop([] = q), do: {peek(q), q}
  def pop(q) when is_list(q), do: {peek(q), tl(q)}

  @doc """
  Returns first time from queue.

  ## Examples

      iex> Matchete.Queue.peek([1, 2, 3])
      1
      iex> Matchete.Queue.peek([])
      nil

  """
  def peek([]), do: nil
  def peek(q) when is_list(q), do: hd(q)
end
