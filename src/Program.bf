using System;
using System.Diagnostics;
class Program
{
	public static void Main(String[] args)
	{
		Runtime.SetCrashReportKind(Runtime.RtCrashReportKind.None);
		if (args == null || args.Count != 1)
		{
			Console.WriteLine("Usage: .exe [DEAL]\n.exe 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643");
			return;
		}

		Stopwatch sw = scope .();
		sw.Start();

		CribbageSolitaire solver = scope .();
		if (!solver.SetDeal(args[0]))
		{
			Console.WriteLine("Invalid Deal");
			return;
		}

		String solution = solver.Solve();
		sw.Stop();

		Console.WriteLine(scope $"Best Score: {solver.Score} Steps: {solution} Took: {sw.Elapsed}");
		delete solution;
	}
}