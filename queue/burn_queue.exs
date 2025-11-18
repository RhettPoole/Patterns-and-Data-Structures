defmodule Q do
  #empty? - This function checks to see if the front and rear list are empty. If it is, it will return a true value, if it's not empty, it will return a false value.
  def empty?({[], []}), do: true
  def empty?(_), do: false

  #enqueue - This operation adds a new item to the queue at the front of the reversed "rear" list in our 2 part queue.
  def enqueue({[], []}, e), do: {[e], []}
  def enqueue({f, r}, e), do: {f, [e | r]}

  #dequeue - Dequeue removes the front element from the front list in our queue.
  #Case 2: "when front list has exactly ONE element (matched with [_]) and r is any rear list". Reverse the rear list and makes it the new front list.
  def dequeue({[], []}), do: {[], []}
  def dequeue({[_], r}), do: {Enum.reverse(r), []}
  def dequeue({[_ | t], r}), do: {t, r}

  #head - Retrieve the the front-most element in our queue, or the next element which will be dequeue'd
  def head({[], []}), do: nil
  def head({[], r}), do: List.last(r)
  def head({[h | _], _}), do: h

  #tail - Retrieves the end-most, or last, element in our queue without removing it.
  def tail({[], []}), do: nil
  def tail({f, []}), do: List.last(f)
  def tail({_, [h | _]}), do: h

  #to_list - This combines both the front and rear lists into one list. It does this by first reversing the rear list and then combining the lists.
  def to_list({f, r}), do: f ++ Enum.reverse(r)

  #from_list - This takes a standard list of elements and creates a queue with all items placed in the "front" list of our queue.
  def from_list(list), do: {list, []}
end

# FESPDC
# From empty list
q0 = Q.from_list([])
IO.inspect(q0, label: "List should be empty")

# Enqueue
q1 = Q.enqueue(q0, 1)
q2 = Q.enqueue(q1, 2)
q3 = Q.enqueue(q2, 3)

# See entire queue
IO.inspect(q3, label: "Entire queue after 3 enqueue's")

# Peek head/tail
IO.inspect(Q.head(q3), label: "Head of queue")
IO.inspect(Q.tail(q3), label: "Tail of queue")

# Dequeue
q4 = Q.dequeue(q3)
q5 = Q.dequeue(q4)
q6 = Q.dequeue(q5)

# Confirm empty
IO.inspect(Q.empty?(q6), label: "Is the queue empty now?")
