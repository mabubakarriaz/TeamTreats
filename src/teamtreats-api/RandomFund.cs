namespace teamtreats_api
{
    public class RandomFund
    {
        public DateOnly Date { get; set; }

        public int TotalAmount { get; set; }

        public int PendingAmount { get; set; }

        public string? MemberName { get; set; }
    }
}
