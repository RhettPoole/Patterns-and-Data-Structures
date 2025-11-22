defmodule Trie do
  def new, do: %{end?: false, children: %{}}

  def empty?(%{end?: false, children: c}), 
    do: map_size(c) == 0
  def empty?(_), do: false

  def add(trie, []), do: %{trie | end?: true}

  def add(%{children: c} = trie, [h | t]) do
    child = Map.get(c, h, new())
    %{trie | children: Map.put(c, h, add(child, t))}
  end

  def contains?(%{end?: e}, []), do: e

  def contains?(%{children: c}, [h | t]) do
    case Map.get(c, h) do
      nil -> false
      sub -> contains?(sub, t)
    end
  end

  def remove(trie, []), do: %{trie | end?: false}

  def remove(%{children: c} = trie, [h | t]) do
    case Map.get(c, h) do
      nil ->
        trie

      sub ->
        updated = remove(sub, t)
        new_c = if empty?(updated), 
do: Map.delete(c, h), else: Map.put(c, h, updated)
        %{trie | children: new_c}
    end
  end

  def prefix(trie, prefix), do: pre(trie, prefix, [])
  defp pre(trie, [], acc), do: collect(trie, acc)

  defp pre(%{children: c}, [h | t], acc) do
    case Map.get(c, h) do
      nil -> []
      sub -> pre(sub, t, acc ++ [h])
    end
  end

  def to_list(trie), do: collect(trie, [])

  defp collect(%{end?: e, children: c}, acc) do
    words = for {ch, sub} <- c, into: [], 
      do: collect(sub, acc ++ [ch])
    if e, do: [acc | List.flatten(words)], 
      else: List.flatten(words)
  end

  def from_list(list), 
    do: Enum.reduce(list, new(), &add(&2, &1))
end

# -----------------------
# Test cases

t = Trie.new()
t = Trie.add(t, ~c"cat")
t = Trie.add(t, ~c"car")
t = Trie.add(t, ~c"dog")

IO.puts("Contains 'cat'? #{Trie.contains?(t, ~c"cat")}")
IO.puts("Contains 'can'? #{Trie.contains?(t, ~c"can")}")

IO.inspect(Trie.prefix(t, ~c"ca"), label: "Prefix 'ca'")
IO.inspect(Trie.to_list(t), label: "To List")

t = Trie.remove(t, ~c"car")
IO.inspect(Trie.to_list(t), label: "After removing 'car'")
