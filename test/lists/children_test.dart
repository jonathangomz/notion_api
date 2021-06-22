import 'package:notion_api/notion/blocks/block.dart';
import 'package:notion_api/notion/blocks/heading.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/blocks/todo.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/lists/children.dart';
import 'package:test/test.dart';

void main() {
  var longJson = [
    {
      "object": "block",
      "id": "71fa679a-f072-4e70-bf52-6b1e770f5c3c",
      "created_time": "2021-05-20T21:01:00.000Z",
      "last_edited_time": "2021-05-26T19:10:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Subtext A ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Subtext A ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": true,
              "color": "default"
            },
            "plain_text": "test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "cae15cef-81c1-477b-a3fa-f5d2686db834",
      "created_time": "2021-05-26T13:37:00.000Z",
      "last_edited_time": "2021-05-26T13:38:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Subtext B", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Subtext B",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "210ebf17-2517-47a7-bae3-29ddc78a9e16",
      "created_time": "2021-05-26T13:37:00.000Z",
      "last_edited_time": "2021-05-26T19:08:30.080Z",
      "has_children": true,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Subtitle B", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Subtitle B",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "5cc87dee-e8a2-4515-94b5-532b6ac4b0cc",
      "created_time": "2021-05-26T13:36:00.000Z",
      "last_edited_time": "2021-05-26T13:36:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {"text": []}
    },
    {
      "object": "block",
      "id": "0f8380c3-50e6-490b-b6ef-200bcbcb0d22",
      "created_time": "2021-05-26T19:14:25.899Z",
      "last_edited_time": "2021-05-26T19:14:25.899Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {
              "content": "Test",
              "link": {"url": "null"}
            },
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": "null"
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "987700fe-1546-4232-9881-72a93c0c5644",
      "created_time": "2021-05-26T19:14:25.899Z",
      "last_edited_time": "2021-05-26T19:14:25.899Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {
              "content": "Lorem ipsum (A)",
              "link": {"url": "null"}
            },
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A)",
            "href": "null"
          },
          {
            "type": "text",
            "text": {
              "content": "Lorem ipsum (B)",
              "link": {"url": "null"}
            },
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (B)",
            "href": "null"
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "9836f854-8b42-4f12-997b-ea7a7e2f582b",
      "created_time": "2021-05-26T19:15:00.000Z",
      "last_edited_time": "2021-05-26T19:15:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {"text": []}
    },
    {
      "object": "block",
      "id": "1b1a4b78-d0bc-4ae0-91cd-b333e4b3bb07",
      "created_time": "2021-05-26T19:23:54.201Z",
      "last_edited_time": "2021-05-26T19:23:54.201Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "68f81a52-d93a-4941-8b60-68e8850830dd",
      "created_time": "2021-05-26T19:23:54.201Z",
      "last_edited_time": "2021-05-26T19:23:54.201Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A)", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A)",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B)", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (B)",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "3ac33bc5-53b3-4e2a-9536-069f1b3a1dcd",
      "created_time": "2021-05-26T19:34:04.519Z",
      "last_edited_time": "2021-05-26T19:34:04.519Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "ffbcfd9f-2c6b-426e-a575-032f409c3009",
      "created_time": "2021-05-26T19:34:04.520Z",
      "last_edited_time": "2021-05-26T19:34:04.520Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "2eb76db2-c716-4c8d-96ac-45a665f553fc",
      "created_time": "2021-05-26T19:42:00.000Z",
      "last_edited_time": "2021-05-26T19:42:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {"text": []}
    },
    {
      "object": "block",
      "id": "70e56831-9f12-4566-ba14-b2166128fcf7",
      "created_time": "2021-05-26T19:43:04.583Z",
      "last_edited_time": "2021-05-26T19:43:04.583Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "44612e85-5554-46aa-acaf-8a2befc0c1d8",
      "created_time": "2021-05-26T19:43:04.583Z",
      "last_edited_time": "2021-05-26T19:43:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ", "link": null},
            "annotations": {
              "bold": true,
              "italic": true,
              "strikethrough": true,
              "underline": true,
              "code": true,
              "color": "default"
            },
            "plain_text": "Lorem ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "ipsum", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": true,
              "color": "default"
            },
            "plain_text": "ipsum",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": " (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": true,
              "strikethrough": true,
              "underline": true,
              "code": true,
              "color": "default"
            },
            "plain_text": " (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "d7118613-505f-4fe3-85f6-81c7a19a0bdc",
      "created_time": "2021-05-26T19:43:00.000Z",
      "last_edited_time": "2021-05-26T19:43:00.000Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {"text": []}
    },
    {
      "object": "block",
      "id": "29c46f08-84ca-49bd-850b-c16201d60fe5",
      "created_time": "2021-05-26T19:54:33.467Z",
      "last_edited_time": "2021-05-26T19:54:33.467Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "bdb007f8-a7c1-433a-94dc-9c682302c321",
      "created_time": "2021-05-26T19:54:33.468Z",
      "last_edited_time": "2021-05-26T19:54:33.468Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "b3d374bb-71d6-4df2-b87c-c8ad03429213",
      "created_time": "2021-05-26T19:55:22.206Z",
      "last_edited_time": "2021-05-26T19:55:22.206Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "29772ead-1a0a-4f0b-9740-05fc1f512ccb",
      "created_time": "2021-05-26T19:55:22.207Z",
      "last_edited_time": "2021-05-26T19:55:22.207Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "6d6f760d-36b5-487f-be23-a2332c503659",
      "created_time": "2021-05-26T20:17:54.330Z",
      "last_edited_time": "2021-05-26T20:17:54.330Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "e3c676fe-abb3-4b07-9bc2-66fc7246e9c6",
      "created_time": "2021-05-26T20:17:54.330Z",
      "last_edited_time": "2021-05-26T20:17:54.330Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "ef79992f-bda3-437e-b05b-22c4f7fde707",
      "created_time": "2021-05-26T20:24:03.890Z",
      "last_edited_time": "2021-05-26T20:24:03.890Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "d6fad7b2-21f8-41ac-a470-e177d1fecbab",
      "created_time": "2021-05-26T20:24:03.891Z",
      "last_edited_time": "2021-05-26T20:24:03.891Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "5919b687-6095-43d7-89fd-65a72d8a91c4",
      "created_time": "2021-05-26T20:27:10.465Z",
      "last_edited_time": "2021-05-26T20:27:10.465Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "1b570380-3a38-459d-bbce-4d494e6b44e1",
      "created_time": "2021-05-26T20:27:10.465Z",
      "last_edited_time": "2021-05-26T20:27:10.465Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "e9938434-b68a-40f2-a0b4-859b3d0fd8ce",
      "created_time": "2021-05-26T21:22:13.003Z",
      "last_edited_time": "2021-05-26T21:22:13.003Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "8232d67a-ba97-4a0e-bbb0-68de60a6ca23",
      "created_time": "2021-05-26T21:22:13.003Z",
      "last_edited_time": "2021-05-26T21:22:13.003Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "42f2130b-ab78-4082-bd8d-c84cef9d05f0",
      "created_time": "2021-05-26T21:26:13.741Z",
      "last_edited_time": "2021-05-26T21:26:13.741Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "504b007c-13fa-41ce-ace8-0d4e2217e5a1",
      "created_time": "2021-05-26T21:26:13.741Z",
      "last_edited_time": "2021-05-26T21:26:13.741Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "9210c54f-84bd-40ba-9b39-e3eebeec6d50",
      "created_time": "2021-06-01T20:10:32.126Z",
      "last_edited_time": "2021-06-01T20:10:00.000Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "A", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "A",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "5f2c7b3b-5562-4a1f-bc16-687dcd20aee3",
      "created_time": "2021-06-01T20:10:00.000Z",
      "last_edited_time": "2021-06-01T20:10:00.000Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "B", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "B",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "eb2f3511-17fa-40cc-ae1d-527c59a485e7",
      "created_time": "2021-06-01T20:10:00.000Z",
      "last_edited_time": "2021-06-01T20:10:00.000Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "C", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "C",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "8968be8a-06d7-46ba-bbe9-fecf6ad50bba",
      "created_time": "2021-06-01T20:36:49.684Z",
      "last_edited_time": "2021-06-01T20:36:49.684Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item A ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item A ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "7b43bd16-8e51-4a6f-ad9f-1d7ee4b2c509",
      "created_time": "2021-06-01T20:36:49.684Z",
      "last_edited_time": "2021-06-01T20:36:49.684Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "B ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "B ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "120ab7aa-67dd-4601-b672-864f0f6c379d",
      "created_time": "2021-06-01T21:30:07.766Z",
      "last_edited_time": "2021-06-01T21:30:07.766Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "c0039c0a-8a26-4482-b30e-81a5ea126afe",
      "created_time": "2021-06-01T21:30:07.766Z",
      "last_edited_time": "2021-06-01T21:30:07.766Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "4f0a4a26-f93c-45ad-8e71-7a42f3293865",
      "created_time": "2021-06-01T21:30:08.515Z",
      "last_edited_time": "2021-06-01T21:30:08.515Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item A ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item A ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "bf78789d-e097-424a-9312-ff9bda19f6ee",
      "created_time": "2021-06-01T21:30:08.515Z",
      "last_edited_time": "2021-06-01T21:30:08.515Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "B ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "B ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "68aff84c-c6b4-427b-aea4-8d173f69baa9",
      "created_time": "2021-06-01T21:32:53.058Z",
      "last_edited_time": "2021-06-01T21:32:53.058Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "520b2dc7-8233-4c39-8551-a97c95fe7760",
      "created_time": "2021-06-01T21:32:53.058Z",
      "last_edited_time": "2021-06-01T21:32:53.058Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "fbd2755d-e4ec-4e65-a33c-2ccbad535d6b",
      "created_time": "2021-06-01T21:32:53.621Z",
      "last_edited_time": "2021-06-01T21:32:53.621Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item A ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item A ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "0c8d0e62-a533-4d67-a0d3-8ccedb637735",
      "created_time": "2021-06-01T21:32:53.621Z",
      "last_edited_time": "2021-06-01T21:32:53.621Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "B ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "B ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "9e7fc475-bf2d-49ac-95a4-6eae2c7a413e",
      "created_time": "2021-06-04T15:02:42.443Z",
      "last_edited_time": "2021-06-04T15:02:42.443Z",
      "has_children": false,
      "type": "heading_1",
      "heading_1": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Test", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Test",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "ee7a4a13-f1b7-4145-83a8-401e29a48046",
      "created_time": "2021-06-04T15:02:42.443Z",
      "last_edited_time": "2021-06-04T15:02:42.443Z",
      "has_children": false,
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (A) ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "Lorem ipsum (A) ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "Lorem ipsum (B) ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": true,
              "code": false,
              "color": "orange"
            },
            "plain_text": "Lorem ipsum (B) ",
            "href": null
          }
        ]
      }
    },
    {
      "object": "block",
      "id": "395f1d2f-2e1e-4396-a2f5-e6c3f2c1d5d0",
      "created_time": "2021-06-04T15:03:42.708Z",
      "last_edited_time": "2021-06-04T15:03:42.708Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item A ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item A ",
            "href": null
          }
        ],
        "checked": false
      }
    },
    {
      "object": "block",
      "id": "7e9a6e4a-9f3a-4d34-81f8-5ff08e1589c8",
      "created_time": "2021-06-04T15:03:42.709Z",
      "last_edited_time": "2021-06-04T15:03:42.709Z",
      "has_children": false,
      "type": "to_do",
      "to_do": {
        "text": [
          {
            "type": "text",
            "text": {"content": "This is a todo item ", "link": null},
            "annotations": {
              "bold": false,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "This is a todo item ",
            "href": null
          },
          {
            "type": "text",
            "text": {"content": "B ", "link": null},
            "annotations": {
              "bold": true,
              "italic": false,
              "strikethrough": false,
              "underline": false,
              "code": false,
              "color": "default"
            },
            "plain_text": "B ",
            "href": null
          }
        ],
        "checked": false
      }
    }
  ];
  group('Children Instance =>', () {
    test('Create new empty instance', () {
      Children children = Children();

      expect(children, isNotNull);
      expect(children.isEmpty, true);
    });

    test('Create new instance with data', () {
      Children children = Children()
          .add(Heading(text: Text('A')))
          .add(Paragraph(text: Text('B')))
          .add(ToDo(text: Text('C')));

      expect(children.isNotEmpty, true);
      expect(children.length, 3);
    });

    test('Create json (for API) from instance', () {
      Map<String, dynamic> children = Children()
          .add(Heading(text: Text('A')))
          .add(Paragraph(text: Text('B')))
          .add(ToDo(text: Text('C')))
          .toJson();

      expect(children['children'], isList);
      expect((children['children'] as List).length, 3);
      expect(((children['children'] as List).first)['type'], 'heading_1');
      expect(((children['children'] as List).last)['type'], 'to_do');
    });

    test('Create instance (from Response) from instance', () {
      Children children = Children.fromJson(longJson);

      List<Block> filtered = children.filterBlocks(onlyLeft: BlockTypes.H1);

      expect(children.isNotEmpty, true);
      expect(filtered, isNotEmpty);
      expect(filtered.length, lessThan(children.length));
    });

    test('Create json (from Response) from instance', () {
      Map<String, dynamic> children = Children.fromJson(longJson).toJson();

      expect(children, isNotNull);
    });

    test('Map from wrong json', () {
      List<dynamic> wrongJsonDatabase = [
        {'foo': 'bar'}
      ];

      Children children = Children.fromJson(wrongJsonDatabase);

      expect(children.isEmpty, true);
    });

    test('Add blocks in distinct ways', () {
      Children children1 = Children(
        heading: Heading(text: Text('Test')),
        paragraph: Paragraph(
          texts: [
            Text('Lorem ipsum (A)'),
            Text(
              'Lorem ipsum (B)',
              annotations: TextAnnotations(
                bold: true,
                underline: true,
                color: ColorsTypes.Orange,
              ),
            ),
          ],
        ),
      );

      Children children2 =
          Children().add(Heading(text: Text('Test'))).add(Paragraph(texts: [
                Text('Lorem ipsum (A)'),
                Text('Lorem ipsum (B)',
                    annotations: TextAnnotations(
                      bold: true,
                      underline: true,
                      color: ColorsTypes.Orange,
                    ))
              ]));

      var json1 = children1.toJson();
      var json2 = children2.toJson();

      expect(json1, json2);
    });
  });
}
