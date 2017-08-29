using Microsoft.Azure.WebJobs;
using Sample2.Service.Models;

namespace Sample2.Functions
{
	public class QueueFunctions
	{
		internal const string UpdateQueueName = "updatequeue";

		[FunctionName(nameof(UpdateDataQueue))]
		public static void UpdateDataQueue(
			[QueueTrigger(UpdateQueueName)]
				DataPoints data)
		{
			ServiceLocator.DataPointsService.Add(data);
		}
	}
}