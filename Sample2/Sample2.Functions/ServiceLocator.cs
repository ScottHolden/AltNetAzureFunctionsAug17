using System;
using Sample2.Service;

namespace Sample2.Functions
{
	public static class ServiceLocator
	{
		private static Lazy<IDataPointsService> m_lazyDataPointsService = new Lazy<IDataPointsService>(() => new InMemoryDataPointsService());
		public static IDataPointsService DataPointsService { get { return m_lazyDataPointsService.Value; } }
	}
}