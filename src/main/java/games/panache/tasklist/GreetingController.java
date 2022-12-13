package games.panache.tasklist;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.atomic.AtomicLong;

record Greeting(long id, String content) {}

@RestController
public class GreetingController {
    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    Logger logger = LoggerFactory.getLogger(GreetingController.class);

    @CrossOrigin(origins = "*")
    @GetMapping("/greeting")
    public Greeting greeting(
            @RequestParam(value = "name", defaultValue = "World") String name
    ) {
        logger.info("greetingのAPIが呼び出されました。");
        return  new Greeting(counter.incrementAndGet(),String.format(template,name));
    }
}