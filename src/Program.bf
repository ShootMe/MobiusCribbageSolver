using System;
using System.Diagnostics;
class Program
{
	public static void Main(String[] args)
	{
		Runtime.SetCrashReportKind(Runtime.RtCrashReportKind.None);
		if (args == null || args.Count != 1)
		{
			Console.WriteLine("Usage: .exe [DEAL | DEAL#]\nex)\n.exe 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643\n.exe 1");
			return;
		}

		Stopwatch sw = scope .();
		sw.Start();

		CribbageSolitaire solver = scope .();
		if (args[0].Length <= 10)
		{
			if (uint32.Parse(args[0]) case .Ok(var dealNum) && dealNum != 0)
			{
				solver.Shuffle(dealNum);
			} else
			{
				Console.WriteLine("Invalid Deal #");
				return;
			}
		} else if (!solver.SetDeal(args[0]))
		{
			Console.WriteLine("Invalid Deal");
			return;
		}

		String solution = solver.Solve();
		sw.Stop();

		String deal = scope .();
		solver.GetDeal(deal);
		Console.WriteLine(scope $"Deal: {deal}\nScore: {solver.Score}\nSteps: {solution}\nTook: {sw.Elapsed}");
		delete solution;
	}
}