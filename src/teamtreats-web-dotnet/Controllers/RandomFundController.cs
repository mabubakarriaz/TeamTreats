using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using NuGet.Configuration;
using System.Net.Http;
using teamtreats_web_dotnet.Models;

namespace teamtreats_web_dotnet.Controllers
{
    public class RandomFundController : Controller
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiUrl;
        public RandomFundController(IHttpClientFactory httpClientFactory, IOptions<ApiSettings> apiSettings)
        {
            _httpClient = httpClientFactory.CreateClient();
            _apiUrl = apiSettings.Value.ApiUrl;
        }

        // GET: RandomFundController
        public async Task<IActionResult> Index()
        {
            try
            {
                //var apiUrl = "http://localhost:9020/RandonFund"; // Replace with your actual API URL
                var response = await _httpClient.GetAsync(_apiUrl);

                if (response.IsSuccessStatusCode)
                {
                    var jsonString = await response.Content.ReadAsStringAsync();
                    var data = JsonConvert.DeserializeObject<List<RandomFund>>(jsonString);
                    return View(data);
                }
                else
                {
                    return StatusCode((int)response.StatusCode, "Error fetching data from API");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        // GET: RandomFundController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: RandomFundController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: RandomFundController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: RandomFundController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: RandomFundController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: RandomFundController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: RandomFundController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
