using System.Collections.Concurrent;
using Sample2.Service.Models;

namespace Sample2.Service
{
	public class InMemoryDataPointsService : IDataPointsService
	{
		private ConcurrentBag<DataPoints> m_dataPoints;

		public InMemoryDataPointsService()
		{
			m_dataPoints = new ConcurrentBag<DataPoints>();
		}

		public DataPoints[] Get()
		{
			return m_dataPoints.ToArray();
		}

		public void Add(DataPoints data)
		{
			m_dataPoints.Add(data);
		}
	}
}