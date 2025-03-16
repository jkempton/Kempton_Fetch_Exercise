### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
For this project, I focused primarily on two key requirements: "No External Dependencies" and "Efficient Network Usage" 
(requirements #2 and #3 from the project directions). One of the main challenges was figuring out how to persist images 
to disk and reload them efficiently without redownloading them from the network. Initially, I had planned to use an external 
framework like Kingfisher, which I’ve successfully used in production apps before. However, I enjoyed the challenge of 
implementing this functionality from scratch, and I now have reusable code for future projects that require custom disk 
persistence and caching. Given that efficient downloading and caching are fundamental to many apps, this was a valuable learning experience.

Another key focus was ensuring a smooth and responsive UI. To achieve this, I leveraged Swift’s async/await pattern along 
with AsyncImage for handling asynchronous operations. This approach helped maintain UI stability, preventing unnecessary 
blocking or freezing. While I didn’t prioritize extensive UI design, my main goal was to architect the app properly.

As an additional feature, I implemented a search bar to allow users to find recipes based on their input. I also briefly 
explored displaying the first frame of the YouTube video in the RecipeDetailView, but I ultimately decided it was a "nice to have" 
rather than a priority.

Overall, this project was a great learning experience, and I’m proud of what I accomplished—even if the final result was 
primarily for my own growth and knowledge.
