class GQLQuery {
  static String createShortVideo = '''
{
  "query": "mutation CreateCreativityShorts(\$title: String!, \$photoId: ID!, \$file: Upload!,\$author: String, \$authorEmail: String!, \$description: String) { shorts: createVideo(data: { videoSection: \"creativity\", state: draft, isShorts: true, name: \$title, file: { upload: \$file }, uploader: \$author, uploaderEmail: \$authorEmail, content: \$description, heroImage: { connect: { id: \$photoId } } }) { id } }",
  "variables": {
    "title": "測試影片",
    "photoId": "236",
    "author": "上傳者(可以為空)",
    "authorEmail": "上傳者email(不可為空)",
    "description": "說明(可以為空)",
    "file": null
  }
}
  ''';

  static String getArticleBySectionSlug = '''
    query (\$slug: String!) {
    posts(
        where: { sections: { some: { slug: { contains: \$slug } } } }
        orderBy: { publishedDate: asc }
    ) {
        id
        slug
        title
        publishedDate
        publishedDateString
        heroImage {
            resized {
                original
                w480
                w800
                w1200
                w1600
                w2400
            }
        }
    }
  }
  ''';

  static String createPreviewImageOfShorts = '''
    {
        query: `
          mutation(\$files: [Upload!]!) {
            multipleUpload(files: \$files) {
              id
            }
          }
        `,
        variables: {
          files: [
            File, // b.txt
            File // c.txt
          ]
        }
      }
  
  ''';

  static String getSections = '''
    query Sections {
      sections(orderBy: { order: asc }) {
          name
          color
          slug
          id
      }
    }
  ''';

  static String getShortBySectionSlug = '''
    query (\$slug: String!) {
    videos(
        where: { isShorts: { equals: true }, videoSection: { equals: \$slug } }
        orderBy: { createdAt: desc }
    ) {
        name
        videoSrc
        uploader
        uploaderEmail
    }
  }
  ''';

  static String getCategoriesBySectionSlug = '''
    query Categories (\$slug:String!){
      categories(
          where: { sections: { every: { slug: { equals: \$slug } } } }
          orderBy: { id: asc }
      ) {
          name
          slug
      }
    }
  ''';

  static String getLiveStreamingLink = '''
    query Events {
      events(
          orderBy: { startDate: desc }
          where: { state: { equals: "published" } }
          take: 1
      ) {
          name
          startDate
          endDate
          link
      }
    }
  ''';

  static String getEditorChoices = '''
  query EditorChoices {
    editorChoices(orderBy: { order: asc }) {
        heroImage {
            resized {
                original
                w480
                w800
                w1200
                w1600
                w2400
            }
        }
        choices {
            slug
            title
        }
    }
  }
  ''';

  static String getArticleBySlug = '''
    query (\$slug: String!) {
      post(where: { slug: \$slug }) {
          id
          slug
          title
          subtitle
          state
          publishedDate
          publishedDateString
          updateTimeStamp
          extend_byline
          heroCaption
          style
          isMember
          og_description
          isFeatured
          isAdult
          apiDataBrief
          apiData
          trimmedApiData
          createdAt
          updatedAt
          writers(orderBy: { id: asc }) {
              id
              name
          }
          photographers(orderBy: { id: asc }) {
              id
              name
          }
          camera_man(orderBy: { id: asc }) {
              name
              id
          }
          designers(orderBy: { id: asc }) {
              id
              name
          }
          engineers(orderBy: { id: asc }) {
              id
              name
          }
          vocals(orderBy: { id: asc }) {
              id
              name
          }
          heroImage {
              id
              name
              waterMark
              topicKeywords
              resized {
                  original
                  w480
                  w800
                  w1200
                  w1600
                  w2400
              }
          }
          relateds(orderBy: { publishedDate: asc }) {
              id
              slug
              title
              subtitle
              adTrace
              css
              apiDataBrief
              apiData
              trimmedApiData
              createdAt
              updatedAt
          }
          tags(orderBy: { id: asc }) {
              id
              slug
              name
          }
          og_title
          categories(orderBy: { order: asc }) {
            id
            name
            slug
          }
          sections(orderBy: { order: asc }) {
              id
              name
              color
              slug
          }
      }
    }
  ''';
}
