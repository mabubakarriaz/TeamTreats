using Microsoft.AspNetCore.Mvc;

namespace teamtreats_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RandonFundController : ControllerBase
    {
        private static readonly string[] RandomNames = new[]
        {
            "Adeel", "Abubakar", "Zohaib", "Kamran", "Mudasir", "Tahir", "Shami", "Taimoor", "Talha", "Kabir"
        };

        private readonly ILogger<RandonFundController> _logger;

        public RandonFundController(ILogger<RandonFundController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetRandonFund")]
        public IEnumerable<RandomFund> Get()
        {
            return Enumerable.Range(1, 5).Select(index => new RandomFund
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TotalAmount = Random.Shared.Next(1500, 3500),
                PendingAmount = Random.Shared.Next(0, 1500),
                MemberName = RandomNames[Random.Shared.Next(RandomNames.Length)]
            })
            .ToArray();
        }
    }
}
