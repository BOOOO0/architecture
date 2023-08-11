package best.server.server.contents.controller;

import best.server.server.contents.domain.Content;
import best.server.server.contents.service.ContentService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ContentController {
    private final ContentService contentService;

    @Autowired
    public ContentController(ContentService contentService) {
        this.contentService = contentService;
    }

    @Transactional
    @PostMapping("/")
    public void saveContent(@RequestParam("text") String text){
        Content content = new Content();
        content.setText(text);
        contentService.save(content);
    }

    @GetMapping("check")
    @ResponseBody
    public List<Content> checkContent(){
        return contentService.findAll();
    }
}
