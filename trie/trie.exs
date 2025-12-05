defmodule Trie do
  # Make a new trie
  def new, do: %{end?: false, children: %{}}

  # Determine if empty
  def empty?(%{end?: false, children: c}),
    do: map_size(c) == 0
  def empty?(_), do: false

  # Base case add
  def add(trie, []), do: %{trie | end?: true}

  # Recursive add, if doesn't exist then create one
  def add(%{children: c} = trie, [h | t]) do
    child = Map.get(c, h, new())
    %{trie | children: Map.put(c, h, add(child, t))}
  end

  # Check for sequence base case
  def contains?(%{end?: e}, []), do: e

  # Check for sequence, recursive
  def contains?(%{children: c}, [h | t]) do
    case Map.get(c, h) do
      nil -> false
      sub -> contains?(sub, t)
    end
  end

  # Remove, just unmark once we hit the end
  def remove(trie, []), do: %{trie | end?: false}

  # Recursive remove
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

  # Return stored prefixes that start with "prefix"
  def prefix(trie, prefix), do: pre(trie, prefix, [])
  # If match
  defp pre(trie, [], acc), do: collect(trie, acc)

  # Keep moving through the tree
  defp pre(%{children: c}, [h | t], acc) do
    case Map.get(c, h) do
      nil -> []
      sub -> pre(sub, t, acc ++ [h])
    end
  end

  # Convert trie back to list
  def to_list(trie), do: collect(trie, [])

  # Gather all sequences that are reachable
  defp collect(%{end?: e, children: c}, acc) do
    words = for {ch, sub} <- c, into: [],
      do: collect(sub, acc ++ [ch])
    # If current word is endpoint, include entire word
    if e, do: [acc | List.flatten(words)],
  else: List.flatten(words)
  end

  # Build tree from list
  def from_list(list),
    do: Enum.reduce(list, new(), &add(&2, &1))
end


# Testing

t = Trie.new()
t = Trie.add(t, ~c"cat")
t = Trie.add(t, ~c"car")
t = Trie.add(t, ~c"dog")

IO.puts("Contains 'cat'? #{Trie.contains?(t, ~c"cat")}")
IO.puts("Contains 'can'? #{Trie.contains?(t, ~c"can")}")

IO.inspect(Trie.prefix(t, ~c"ca"), label: "Prefix ca")
IO.inspect(Trie.to_list(t), label: "To List")

t = Trie.remove(t, ~c"car")
IO.inspect(Trie.to_list(t), label: "After removing 'car'")
