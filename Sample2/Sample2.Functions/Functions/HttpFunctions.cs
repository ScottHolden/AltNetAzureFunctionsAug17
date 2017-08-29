using System.Net;
using System.Net.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Sample2.Service.Models;

namespace Sample2.Functions
{
	public class HttpFunctions
	{
		[FunctionName(nameof(GetData))]
		public static DataPoints[] GetData(
			[HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route = "data")]
				HttpRequestMessage request)
		{
			return ServiceLocator.DataPointsService.Get();
		}

		[FunctionName(nameof(UpdateData))]
		public static HttpResponseMessage UpdateData(
			[HttpTrigger(AuthorizationLevel.Anonymous, "PUT", Route = "data")]
				DataPoints requestBody,
			[Queue(QueueFunctions.UpdateQueueName)]
				ICollector<DataPoints> collector)
		{
			collector.Add(requestBody);

			return new HttpResponseMessage(HttpStatusCode.Accepted);
		}
	}
}