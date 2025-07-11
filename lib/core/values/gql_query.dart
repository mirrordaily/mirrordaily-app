class GQLQuery {
  static String getFeaturesTopic = '''
      query Topics {
        topics(
            orderBy: { sortOrder: asc }
            where: { isFeatured: { equals: true }, state: { equals: "published" } }
        ) {
            id
            name
            slug
        }
      }
  ''';

  static String getArticleListByTag = '''
  query (\$name: String!, \$take: Int, \$skip: Int) {
    posts(
        where: { state: { equals: "published" }, OR: [
        { tags: { some: { name: { equals: \$name } } } }
        { tags_algo: { some: { name: { equals: \$name } } } }
      ] }
        take: \$take
        skip: \$skip
        orderBy: { createdAt: desc }
    ) {
        tags {
            name
        }
        slug
        id
        title
        createdAt
        publishedDate
        categories {
            name
        }
        heroImage {
            resized {
                w800
            }
        }
        sections {
            color
            name
        }
    }
}
  ''';

  static String getArticleListByWriter = '''
     query (\$name: String!, \$take: Int, \$skip: Int) {
    posts(
      where: {
        OR: [
          { writers: { some: { name: { equals: \$name } } } }
          { photographers: { some: { name: { equals: \$name } } } }
          { camera_man: { some: { name: { equals: \$name } } } }
          { designers: { some: { name: { equals: \$name } } } }
          { engineers: { some: { name: { equals: \$name } } } }
          { vocals: { some: { name: { equals: \$name } } } }
        ]
      }
      take: \$take
      skip: \$skip
      orderBy: { createdAt: desc }
    ) {
      slug
      id
      title
      createdAt
      publishedDate
      categories {
        name
      }
      heroImage {
        resized {
          w800
        }
      }
      sections {
        color
        name
      }
    }
  }
  ''';

  static String getTopicBySlug = '''
    query (\$slug: String!) {
    topic(where: { slug: \$slug }) {
        type
        leading
        tags{
          name
        }
        posts (orderBy: { publishedDate: desc }) {
            apiDataBrief
            id
            title
            slug
            tags{
              name
            }
            heroImage {
                resized {
                    w800
                }
            }
        }
        slideshow_images {
            resized {
                original
                w480
                w800
                w1200
                w1600
                w2400
            }
        }
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
        heroVideo {
            videoSrc
        }
    }
  }
  ''';

  static String getTopicList = '''
    query Topics {
      topics(orderBy: { sortOrder: asc }) {
        apiDataBrief
        heroImage {
          resized {
            original
            w480
            w800
            w1200
            w1600
            w2400
          }
          waterMark
          copyRight
          createdAt
        }
        slug
        name
         posts {
            id
        }
      }
    }
  ''';

  static String createShortVideo = '''
    mutation CreateCreativityShorts(
      \$title: String!,
      \$photoId: ID!,
      \$file: Upload!,
      \$author: String,
      \$authorEmail: String!,
      \$description: String
    ) {
      shorts: createVideo(
        data: {
          videoSection: "creativity"
          state: "draft"
          isShorts: true
          name: \$title
          file: { upload: \$file }
          uploader: \$author
          uploaderEmail: \$authorEmail
          content: \$description
          heroImage: { connect: { id: \$photoId } }
        }
      ) {
        id
      }
    }
  ''';

  static String getArticleBySectionOnlySlug = '''
  query (\$slug: String!, \$take: Int, \$skip: Int) {
    posts(
      where: { 
        sections: { some: { slug: { contains: \$slug } } } 
      }
      take: \$take
      skip: \$skip
      orderBy: { publishedDate: desc }
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

  static String getArticleBySectionSlug = '''
    query (\$slug: String!, \$take: Int, \$skip: Int,\$category_slug: String!) {
      posts(
        where: { 
          categories: { some: { slug: { equals: \$category_slug } } }
        sections: { some: { slug: { contains: \$slug } } } }
        take: \$take
        skip: \$skip
        orderBy: { publishedDate: desc }
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
  mutation CreateShortsPreview(\$name: String!, \$file: Upload!) {
      photo: createPhoto(data: { name: \$name, imageFile: { upload: \$file }}) {
        id
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
    query Categories (\$slug: String!) {
      categories(
        where: { sections: { some: { slug: { equals: \$slug } } } }
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
      editorChoices(orderBy: { order: desc }
        where: { state: { equals: "published" } }) {
        id
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

  static String getArticleById = '''
    query (\$id: ID!) {
      post(where: { id: \$id }) {
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
          createdAt
          updatedAt
          publishedDate
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
        tags(orderBy: { id: asc }) {
          id
          slug
          name
        }
        tags_algo(orderBy: { id: asc }) {
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
        manualOrderOfRelateds
        Warnings{
            content
        }
      }
    }
  ''';

  static String getExternalArticleById = '''
    query (\$id: ID!) {
      external(where: { id: \$id }) {
          id
          title
          state
          publishedDateString
          extend_byline
          thumb
          thumbCaption
          brief
          content
          createdAt
          updatedAt
          sections(orderBy: { order: desc }) {
            name
            color
        }
         tags {
            id
            name
        }
        relateds (orderBy: { publishedDate: desc }){
            title
            sections {
                name
            }
            heroImage {
                resized {
                    w800
                }
            }
        }
      }
    }
  ''';

}
