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

	public const String[?] DEALS = .(
		"T64K493TA553A_Q672QA6A95K5T_8Q7K8Q89J2792_3JT4J84J26K73", //Random Deal #137688 with lowest score I found so far of 76
		"75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643", //1
		"78K4J959J92T2_73JAK65597KAA_KTTA3Q3844238_T686Q4Q7J65Q2",
		"3299T9KAT79Q3_72864JQ8T6545_T58A42J36J8K6_Q2JA77KQK543A",
		"88Q5TJ7363J32_4TA3Q6J9795K2_5T272QA84489K_AJAT467K569KQ",
		"275JAJ399TKT8_Q567J3586494J_5637T2A4K8QK7_T64QA9A2QK238",
		"Q73A3366947AQ_2522TKJ697644_5595839QKA8KT_JJQ8278JATKT4",
		"65389J4K8J679_4J738T24KQ749_JAKQ53KA62926_553A8AQ7TTTQ2",
		"A5597339K2J7K_9QQQ22J486QTA_AJ8T68K623J75_T4A497K843T56",
		"Q542KK3J5A677_A6K25T7T68J73_Q5J3A984T39KJ_2TA692Q8984Q4",
		"639QJ68J5373A_KJ4K7AQQ2996K_4KT86A854T287_JT559AQ2724T3", //10
		"KAT7K4J52KQ64_T7A265J47A42T_Q98828AJK9366_QQ539T953738J",
		"7Q7QK4Q29TQ48_TA2453A5T7A3T_K8J6J53K7J266_A43598K26J899",
		"A24875TK679QT_4A93J44JK337Q_62Q9T2J55A5KJ_6T2AK8Q893876",
		"4K2AK7J528543_T869Q97A782KJ_563J7T56TAQT3_9JQQ4634K9A82",
		"487T584349959_24J27Q53QA7QA_Q6A96TJ6K683K_27J35T2TKJAK8",
		"T982275A74K2J_66A7429JQT88T_83T63K5Q953KQ_7QA96A434JJ5K",
		"A266473TK3559_92JQ872K9AJ6A_9KQ27K8T64TQJ_AQ83T3584J754",
		"T686375TTJQAK_K3A834563QA29_2J5KAQ7872579_JJ2494QK89T46",
		"37862994Q235T_T9Q369Q48785J_T2J525KA47AA3_8K6K64KJAJTQ7",
		"7838KK9J55Q92_9A4A7638A8246_3QK6T2QT37JKT_746255T4AQ9JJ", //20
		"2AK22Q345J539_6TK3AKQ769837_QT5KJT4889JA7_596A862QJT447",
		"JK98Q67A8JTQA_27KT7A298J662_T3QQ8574399TK_J34AK65425543",
		"6629TQ39T3T58_J855Q7AJ4KAA2_J38Q49647K9J2_6K47A258T37KQ",
		"8K52448JQ7A75_836QTTJA92926_928739QKK44JT_5J35Q7KA66T3A",
		"789A244QA597Q_A6752J68422TK_TA3JJ68459357_J3TK398K6QQTK",
		"2J5Q6A8943K78_353A842A75KQ7_A7TQ284K549J6_TT2J63KQT9J96",
		"4JJ55Q86QTJ3K_Q8K3T79765K35_9A38A4K742Q9A_2A8J7T624269T",
		"49TQ84ATT4583_TJQ86KK33JK6J_K84J56526A9A3_27259Q7Q77A92",
		"J6J672582883T_4Q55767KK96AA_2443T2QAKTA9Q_Q4J3JK78959T3",
		"T2AA753K89Q78_44K5J359TTQ4J_6387656J4QA6K_22T9A32K98J7Q", //30
		"JK9644495693A_AQ82K78K85K6T_27Q773A5TJ6J2_AT45T2J9338QQ",
		"JKQK6692KJ544_A9T3QT7488K93_6A7J8QT32456A_8275Q5JA32T97",
		"ATA77A43274Q2_7T483JJQJ9236_J8Q6TAK5549K9_TQK9356256K88",
		"TJ3AT632775J7_TT6Q34K9596A5_244Q827Q3J959_68KQJ824AKK8A",
		"4544Q3A7J25J2_7T489QK7AK726_836986258KQQT_TJK353TA99JA6",
		"A29J6A55938K4_7823JATQ57Q87_J9AT26746KQ46_QTKK324J9T583",
		"7ATA2QJ58A465_Q74J433K95K6T_T3273659K79J2_486K29T8AQQJ8",
		"3T3A32TA72J68_QT4579457A6KQ_89JK59JA3T5Q2_87J46K8492QK6",
		"TJK643JQ985AQ_A53873K5TAKT2_Q92264T93974Q_5A664788J2JK7",
		"A3Q3JT2T4898T_49474A957QKQK_T6JA722K87K96_63552AQJ536J8", //40
		"287AQA744J4JQ_5354T2JA9TA77_86JKT658K5K6K_T3932Q369892Q",
		"K3484J7A922AK_A6T759T825878_JQQ43K64J939T_35Q6TJ62KA75Q",
		"63Q85932A8268_5TTKATJ767769_J4K42895Q3Q9A_34T2K4QAJK5J7",
		"6J7T5T7J6QKQK_AA95783396785_TAJQ4J2Q83822_A2496TK44359K",
		"62QJ49T37T797_332J56T8789KK_A9458AJQJ6624_T24A5K3A8QK5Q",
		"J7TT66Q7Q9948_835QQ66AJ2TK3_288794J5595T7_3A443KKA2KJ2A",
		"JTTQ6KK56876Q_J448AQ53KAJ47_TA98J2423Q926_TA92875395K37",
		"3AJQ85K84T9Q7_378A42T6J9J2Q_69KTK4J36QA38_52K476A597T25",
		"753688K82QAQ4_Q2A644QTT4399_2J62K6T7JA775_J5ATK9KJ59338",
		"9K3JT24AJQ58A_K32876J8T3245_6JT7249A365AQ_6K458K97QT9Q7", //50
		"T49Q9475JA3KJ_5J296Q4K3K3A6_Q783T75TJK589_6A684872T22QA",
		"48T85249624JA_KT67J5A2A9827_837Q354TQTQ63_537KK9JJAK9Q6",
		"96JT4Q7QQ7KT9_57A62JK4262TK_83AQ764985839_J3K5A82A3T5J4",
		"6TQAQ6T95TJKK_A68AJ2275TA9Q_3998JJ887765K_QK44523724433",
		"25JQ68Q32T96J_55894647QTKA7_K872T2K3JQA83_9T46A47A9J35K",
		"467AATTQ4J456_8TQ63359T382A_QA263J9J57K84_K2JKQ75K98297",
		"775T75K63T928_2Q38AK483294T_69A9Q5J4AQ2K7_KJQT5J8AJ6634",
		"JA3A58244783K_789QK8T6K73J5_Q92QJ67954TQ9_K2TT4J63AA562",
		"K7449A2Q36KA9_Q53J94TQ53JTA_5583J24T77T6J_AK8Q72K829668",
		"7J936Q56KTK8J_KA934QQ765Q4T_783T38229946A_TJK85J7A245A2", //60
		"Q9K37742Q6JAA_8Q3J5A8A55KK4_99T2T847J463T_Q563K792JT682",
		"K476T255K398J_3A72KA838JK8Q_26423AJ5JQ67T_499T6A5T497QQ",
		"5364T83JK8427_JA6Q23749AKJ8_T55AQA7964K57_KJ963T8T2Q92Q",
		"Q65J5Q7AK6833_5529QJ7878K46_894QAT4373TJ6_49KJATK22A9T2",
		"99774AKT4AJ26_A85AJ9836KQ45_6TJ282QJ9QK5K_5T43236Q3778T",
		"5AAAT9827J426_KQ28QK337T9T6_JK9K457A8J5J3_4Q28Q7643956T",
		"TAK97Q36K7824_8575A9J53K78T_2JQ945J468K9T_Q64A23QJT6A32",
		"28TA84J36T489_A92KAAK623K79_J6TQT59J35J52_QQ873Q65747K4",
		"6T3A7573J8QAK_6T93Q5K575428_6J2A64TJTK423_892A9Q87Q9K4J",
		"QQ43QJA48K887_TAA9294677264_992QJJ5ATTK75_T26J833535KK6", //70
		"6QAQ85QK4J5AK_889TJT787K346_J222539492373_K4AT69T7Q56AJ",
		"925Q35T6A3827_734697T9K758J_KA8JJQA46QJ43_59TK2K4TA28Q6",
		"427K248Q9QJTA_645TJ3326KK6A_38978329QK8T6_7A5947JA55QJT",
		"JQJAQT9935AK6_75264Q2JAAKK6_3939T7T57472K_3T852886J48Q4",
		"T99K52T47AA3J_7KA65J8547289_6TKQQ7Q685JA3_38642KQ93JT42",
		"Q4T497Q28QJA8_976Q8T5232A23_6J458633K9K6K_JT7T4A95J75KA",
		"3Q249JA4AK659_896725K3TJJ87_T839Q628TQJ5A_K76T42KA53Q47",
		"564K5A78AA85T_22T473J2T98K6_K7T92JQJJ43K6_Q9Q6Q7985A433",
		"359A27759T652_K24T373KK62AQ_6JT765J8QJ993_8JKA4TA848QQ4",
		"28T47948Q35J5_A995AQT2K7J43_56ATJQ6TA8J4Q_K72276369K38K", //80
		"8A894Q24633K8_7KTT5469277QJ_J2J3TT7QK9Q52_A85AJK4636A59",
		"J5343JK472524_A7Q86A6A62TJQ_579A96TJ957TQ_Q82T3KK8K4398",
		"TJ3Q2QT498573_46QJ9348Q6KAJ_4JKK29752658T_T377K5A896AA2",
		"83TK5J564J427_79QAQK8A5279K_A642T7938J2T3_46TA39Q8KQ6J5",
		"26A35T85622J5_3Q4JK4AQ458A2_K76J9TKJ39T93_74TK886977QQA",
		"T78A456427457_3K6KQ98JKAJ25_365J3Q3QTT9TJ_87AA2849KQ926",
		"8T2247QQ263J8_T44859K55T9JK_K7J7A63438Q66_5AKJ79TA2QA39",
		"A8945924976T2_7T72666KJJ5T5_JQKA33882TAJQ_4A85KK739Q3Q4",
		"23AJJ595KAJQ6_T7865TQ478T74_692J5Q94K69A2_4838A3327TQKK",
		"K8JQ8AQ59T732_545TA23J6843J_66574T892Q99T_7AK263QKA7JK4", //90
		"39833459AT6K6_JK72Q7A5J265Q_TQ2A7J8K458K3_6472QJT48A99T",
		"T622K8K4Q9T95_Q5TKJ54Q4A8QK_A5J7396J846A3_86A292J7T7337",
		"7264J386T9KQA_QKAJKA77TK53J_8457385TT9844_9Q2J26A9563Q2",
		"68T8445Q42737_95J27J4A92Q6K_J29TAQQ3AKK8J_KTT7A63983565",
		"J665Q547TA233_AJK6574Q3483K_ATKTQ2T79AJ42_295J8997QK868",
		"AKA3J94JJ483J_8QKQ538K7T799_27A2K52Q8AT92_4TT65534667Q6",
		"J22835QJ54329_97TQ347A7T48K_2T68J5K549K6Q_QKT986A3JA67A",
		"A535QK49T6KJJ_5693829JT2TK3_728QQT4K32Q87_AA66459774J8A",
		"Q767523JJQTQ5_962AK836K2A4K_A78J49847K39T_Q25834JTAT956",
		"85K23595J72JT_TA74Q46A96Q63_2J48TT6QA5A78_7Q982J4K3K93K", //100
		"Q5486J7662AT8_A63A744Q75A2T_98TK2K78T53J9_KK5Q392Q943JJ",
		"TJJ853A3KT269_2437QQAK7A9JQ_T94KK79866527_835284T5J4AQ6",
		"634782T5JTJ9A_5K7J44Q9T3A2T_86A84239K8755_JQ79Q2663KKQA",
		"92Q6A5J77K68A_TJT3K59A268K5_37J3A4J49443Q_598KTT78Q6Q22",
		"4K8585QTA4QQK_5882334792697_ATJ29TJ57372K_6A9AJQJK6T643",
		"K4KQ472527838_839QKQ93TJ7A3_4AA2A5JT662J7_Q6855KJT9649T",
		"766T36K94KQ53_5KJQTA44J7757_JJ2983TAQ49AT_252Q6K88823A9",
		"K5TQ7AJ59K37T_6Q398K5J45A89_2JA677AK62QT4_T43J32692Q848",
		"7AJ5Q683K4JA2_Q56TK88K228TA_7945T4693K37J_T37A5Q6J2499Q",
		"92Q2A643JT882_Q4547398KA38Q_QK43A52A5K5TJ_J66T776TKJ997", //110
		"4K7A846KA259Q_T56239K3783T4_T8Q4J7KT9J26Q_6J5JA3928Q75A",
		"2AJ5AT7Q9685A_297JT68J489J8_3KT43K6QQA955_Q374263KT24K7",
		"5TKTJ52J9546J_A923QQ66728A3_3939QAQ48T4K8_T777K64K5JA82",
		"7497TKAA6Q583_JT2Q97652KQ88_8465QJ29J4333_5TK76A2A9JKT4",
		"47986Q8282T56_37KA53T99QQKJ_4758KJ647QAAK_35229J4TT6J3A",
		"5T4K6J873A954_QT2A62T8694Q3_J368A5453778K_99JK27K2ATQQJ",
		"QQ789237952J3_2TKT8TAJ8J964_4A558735QK446_62TKKJ3A9A6Q7",
		"2479K694T78T7_5T3J65K99A8J7_26352A3QA32Q8_KK45T4Q86AJJQ",
		"JKQ49JAQ6TT48_AJ267T3252A57_358J73A8664K9_KQT987QK23954",
		"7T75K598K3Q32_Q94496522KT38_Q9A384Q6TA8JK_J74TAJ526JA76" //120
		);

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
		var seed;
		uint32 NextRandom(ref uint32 seed)
		{
			seed = (.)(((uint64)seed * 16807) % 0x7fffffff);
			return seed;
		}

		//Initialize deck of cards to AC,..,KC,AD,..,KD,AH,..,KH,AS,..,KS
		for (int i = 0; i < 52; i++)
		{
			int id = i >= 39 ? i - 13 : i >= 26 ? i + 13 : i;
			int c = (id % 13);
			Cards[i] = .(c);
		}

		//Shuffle deck
		for (int i = 0; i < 7; i++)
		{
			for (int j = 0; j < 52; j++)
			{
				int k = NextRandom(ref seed) % 52;
				Card temp = Cards[j];
				Cards[j] = Cards[k];
				Cards[k] = temp;
			}
		}

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
}