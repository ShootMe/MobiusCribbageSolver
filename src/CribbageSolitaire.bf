using System;
using System.Collections;
public class CribbageSolitaire
{
	private Card[52] Cards;
	private int[4] Counts;
	public int Score;
	private int StackSum;
	private int StackStart;
	private Move[52] MovesMade;
	private int MovesMadeCount;
	private uint32 MovesMadePiles;

	public String Solve()
	{
		State[] closed = new .[14 * 14 * 14 * 14];
		Queue<uint16> open = new .(40'000);
		{
			State state = GetState();
			open.Add(state.Counts);
			closed[state.Counts] = state;
		}

		State* solution = &closed[^1];
		while (open.Count > 0)
		{
			uint16 index = open.PopFront();
			State* current = &closed[index];
			if (current.Evaluated == 1) { continue; }
			current.Evaluated = 1;

			if (index == 0)
			{
				if (solution.Score < current.Score) { solution = current; }
				continue;
			}

			Counts[0] = index % 14;
			Counts[1] = (index / 14) % 14;
			Counts[2] = (index / 196) % 14;
			Counts[3] = index / 2744;
			Score = current.Score;

			AddStates(closed, open, current);
		}

		Counts = default;
		Score = solution.Score;

		String solutionStr = new .();
		while (solution != null)
		{
			int cardsMoved = (solution.Previous != null ? solution.Previous.TotalCount : 52) - solution.TotalCount;
			int moved = solution.Moves;
			if (cardsMoved > 0)
			{
				String stackStr = scope .();

				while (cardsMoved > 0)
				{
					cardsMoved--;
					int pile = moved & 0x3;
					stackStr.Insert(0, scope $"{pile + 1}");
					moved >>= 2;
				}
				stackStr.Append('_');
				solutionStr.Insert(0, stackStr);
			}
			solution = solution.Previous;
		}
		solutionStr.Length--;

		delete closed;
		delete open;
		return solutionStr;
	}
	//Try all stacks and save the best
	private void AddStates(State[] closed, Queue<uint16> open, State* parent)
	{
		uint8[13] indexes = default;
		uint8 i = 0;
		int depth = 0;
		bool added = false;
		repeat
		{
			repeat
			{
				uint8 count = (.)Counts[i++];
				if (count == 0) { continue; }

				Move move = .(i - 1, (i - 1) * 13 + count - 1);
				move.Score = CalculateScore(move);
				if (move.Score == 255) { continue; }

				MakeMove(move);
				indexes[depth++] = i;
				added = false;
				i = 0;
			} while (i < 4);

			if (!added)
			{
				State state = GetState();
				State* next = &closed[state.Counts];
				if (state.Score > next.Score || next.Previous == null)
				{
					*next = state;
					next.Previous = parent;
					open.Add(state.Counts);
				}
			}

			added = true;
			while (i == 4 && depth > 0)
			{
				i = indexes[--depth];
				UndoMove();
			}
		} while (i < 4 || depth > 0);
	}
	private uint8 CalculateScore(Move move)
	{
		Card card = Cards[move.Card];
		int rank = (.)card.Rank + 1;
		if (rank > 10) { rank = 10; }

		int nextSum = StackSum + rank;
		if (nextSum > 31) { return 255; }

		//+2 for 15 or 31 or Jack first
		uint8 score = ((nextSum & 0xf) == 0xf || (StackSum == 0 && card.Rank == .Jack)) ? 2 : 0;

		//Pairs
		if (StackSum >= rank)
		{
			int index = MovesMadeCount - 1;
			uint8 count = 0;
			while (index >= StackStart && Cards[MovesMade[index].Card].Rank == card.Rank)
			{
				index--;
				count += 2;
				score += count;
			}
		}

		//Runs
		if (MovesMadeCount - StackStart >= 2)
		{
			uint8 min = (.)card.Rank;
			uint8 max = min;
			uint8[13] cardsSeen = default;
			cardsSeen[min] = 1;
			uint8 best = 0;
			for (int i = MovesMadeCount - 1; i >= StackStart; i--)
			{
				uint8 runRank = (.)Cards[MovesMade[i].Card].Rank;

				if (cardsSeen[runRank] == 1) { break; }
				cardsSeen[runRank] = 1;

				if (runRank < min) { min = runRank; }
				if (runRank > max) { max = runRank; }

				uint8 count = (.)(MovesMadeCount - i);
				if (count >= 2 && max - min == count) { best = count + 1; }
			}
			score += best;
		}

		return score;
	}
	public void MakeMove(Move move)
	{
		MovesMade[MovesMadeCount++] = move;
		Counts[move.Pile]--;
		int rank = (.)Cards[move.Card].Rank + 1;
		if (rank > 10) { rank = 10; }
		MovesMadePiles = (MovesMadePiles << 2) | move.Pile;
		StackSum += rank;
		Score += move.Score;
	}
	public void UndoMove()
	{
		Move move = MovesMade[--MovesMadeCount];
		Counts[move.Pile]++;
		int rank = (.)Cards[move.Card].Rank + 1;
		if (rank > 10) { rank = 10; }
		MovesMadePiles >>= 2;
		StackSum -= rank;
		Score -= move.Score;
	}
	private State GetState()
	{
		return .()
			{
				Score = (.)Score,
				Counts = (.)Counts[3] * 2744 + (.)Counts[2] * 196 + (.)Counts[1] * 14 + (.)Counts[0],
				Moves = MovesMadePiles
			};
	}
	public void Shuffle(uint32 seed)
	{
		CribbageRandom rng = scope .(seed);
		//Initialize deck of cards to A,A,A,A,2,2,2,2,..,K,K,K,K
		for (int i = 0; i < 52; i++)
		{
			Cards[i] = .(i >> 2);
		}

		//Shuffle deck
		for (int32 j = 51; j >= 1; j--)
		{
			int k = rng.Next(0, j + 1);
			Card temp = Cards[j];
			Cards[j] = Cards[k];
			Cards[k] = temp;
		}

		//Rearrange to internal representation
		Card[52] temp = default;
		for (int i = 0; i < 52; i++)
		{
			int pile = 3 - (i & 3);
			int pos = 12 - (i >> 2);
			temp[pile * 13 + pos] = Cards[i];
		}
		Cards = temp;

		//Reset fields
		Counts = .(13, 13, 13, 13);
		MovesMadeCount = 0;
		StackSum = 0;
		StackStart = 0;
		Score = 0;
		MovesMadePiles = 0;
	}
	public void GetDeal(String strBuffer)
	{
		for (int i = 0; i < 52; i++)
		{
			strBuffer.Append(Cards[i].RankChar);
			if ((i + 1) % 13 == 0) { strBuffer.Append('_'); }
		}
		strBuffer.Length--;
	}
	public bool SetDeal(StringView cards)
	{
		if (cards.Length <= 0) { return false; }

		int count = 0;
		bool isHex = cards[0] == 'x' || cards[0] == 'X';
		uint8[13] seen = default;
		for (int i = 0; i < cards.Length; i++)
		{
			char8 c = cards[i];
			int rank = 0;
			switch (c) {
				case '1': rank = 0; break;
				case '2': rank = 1; break;
				case '3': rank = 2; break;
				case '4': rank = 3; break;
				case '5': rank = 4; break;
				case '6': rank = 5; break;
				case '7': rank = 6; break;
				case '8': rank = 7; break;
				case '9': rank = 8; break;
				case 'A','a','T','t': rank = (c == 'T' || c == 't' || isHex) ? 9 : 0; break;
				case 'B','b','J','j': rank = 10; break;
				case 'C','c','Q','q': rank = 11; break;
				case 'D','d','K','k': rank = 12; break;
				default: continue;
			}
			ref uint8 seenRank = ref seen[rank];
			if (seenRank >= 4) { return false; }
			Cards[count] = .(rank);
			count++;
			seenRank++;
		}

		if (count != 52) { return false; }
		Counts = .(13, 13, 13, 13);
		MovesMadeCount = 0;
		StackSum = 0;
		StackStart = 0;
		Score = 0;
		MovesMadePiles = 0;

		return true;
	}
	public override void ToString(String strBuffer)
	{
		for (int i = 0; i < 13; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				strBuffer.Append(i >= Counts[j] ? '-' : ' ');
				strBuffer.Append(Cards[j * 13 + i].RankChar);
			}
			strBuffer.Append('\n');
		}
		strBuffer.Append(scope $"Score: {Score} Stack: {StackSum}");
	}
	public struct Move
	{
		public uint8 Pile;
		public uint8 Card;
		public uint8 Score;
		public this(uint8 pile, uint8 card)
		{
			Pile = pile;
			Card = card;
			Score = 0;
		}
	}
	public struct State
	{
		public uint32 Moves;
		public uint16 Counts;
		public uint8 Score;
		public uint8 Evaluated;
		public State* Previous;
		public int TotalCount => (Counts % 14) + ((Counts / 14) % 14) + ((Counts / 196) % 14) + (Counts / 2744);
	}
	public struct Card
	{
		private const char8[14] Ranks = "A23456789TJQK-";
		public Rank Rank;
		public char8 RankChar => Ranks[(.)Rank];

		public this(int rank) { Rank = (Rank)rank; }
	}
	public enum Rank : uint8
	{
		Ace = 0,
		Two,
		Three,
		Four,
		Five,
		Six,
		Seven,
		Eight,
		Nine,
		Ten,
		Jack,
		Queen,
		King,
		None
	}
	public class CribbageRandom
	{
		private uint64 value1, value2;

		public this(uint64 seed)
		{
			uint64 Initialize(uint64 seed)
			{
				var seed;
				seed ^= seed >> 33;
				seed *= (uint64)18397679294719823053;
				seed ^= seed >> 33;
				seed *= (uint64)14181476777654086739;
				seed ^= seed >> 33;
				return seed;
			}
			value1 = Initialize(seed);
			value2 = Initialize(value1);
		}
		public int32 Next(int32 min, int32 max)
		{
			uint64 Advance()
			{
				uint64 num1 = value1;
				uint64 num2 = value2;
				value1 = value2;
				num1 ^= num1 << 23;
				num1 ^= num1 >> 17;
				num1 ^= num2;
				num1 ^= num2 >> 26;
				value2 = num1;
				return value1 + value2;
			}
			return min + (int32)(Advance() % (.)(max - min));
		}
	}
}