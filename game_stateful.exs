# In your editor, write a stateful process to simulate a turn-based game between two players.

defmodule Game do
  def start(state) do
    spawn(fn -> loop(state) end)
  end

  defp loop(state) do
    receive do
        {:move, player, action} ->
          if player == state.turn do
            IO.puts{"#{player} played: #{action}"}

            new_state = %{
              turn: next_player(player),
              moves: [{player, action} | state.moves]
            }

            loop(new_state)
          else
            IO.puts("It's not #{player}'s turn.")
            loop(state)
          end
    end
  end

  defp next_player(:player1), do: :player2
  defp next_player(:player2), do: :player1
end

initial_state = %{turn: :player1, moves: []}
pid = Game.start(initial_state)

send(pid, {:move, :player1, "draw card"})
send(pid, {:move, :player1, "roll dice"}) #Should be rejected
send(pid, {:move, :player2, "play sword"})

:timer.sleep(100)
