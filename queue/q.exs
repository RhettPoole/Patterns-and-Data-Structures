defmodule Q do
  def empty({[], []}), do: true
  def empty(_), do: false

  def enqueue({[], []}, e), do: {[e], []}
  def enqueue({f, r}, e), do: {f, [e | r]}

  def dequeue({[], []}), do: {[], []}
  #May need to seperate r with h/t
  def dequeue({[_], r}), do: {Enum.reverse(r), []}
  def dequeue({[_ | t], r}), do: {t, r}

  def head({[], []}), do: nil
  def head({[h | _], _}), do: h
  def head({[], r}), do: List.last(r)

  def tail({[], []}), do: nil
  def tail({f, []}), do: List.last(f)
  def tail({[_], [h | _]}), do: h

  def toList({f, r}), do: f ++ Enum.reverse(r)
  def fromList(list), do: {list, []}
end

#FESPDC
q0 = Q.fromList([])
IO.inspect(Q.empty(q0), label: "Is queue empty?")

q1 = Q.enqueue(q0, 1)
q2 = Q.enqueue(q1, 2)
q3 = Q.enqueue(q2, 3)

IO.inspect(q3, label: "Queue after 3 enqueue's")
IO.inspect(Q.head(q3), label: "Head of queue")
IO.inspect(Q.tail(q3), label: "Tail of queue")

q4 = Q.dequeue(q3)
q5 = Q.dequeue(q4)
q6 = Q.dequeue(q5)

IO.inspect(q6, label: "Queue after 3 dequeue's (Should be empty)")

q7 = Q.enqueue(q6, 1)
q8 = Q.enqueue(q7, 2)
q9 = Q.enqueue(q8, 3)
