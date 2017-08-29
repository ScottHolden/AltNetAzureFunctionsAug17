using Sample2.Service.Models;

namespace Sample2.Service
{
	public interface IDataPointsService
	{
		DataPoints[] Get();

		void Add(DataPoints data);
	}
}